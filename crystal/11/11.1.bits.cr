# Takes 0.5 seconds to complete

input = File.read("#{__DIR__}/../../inputs/11")

def valid?(floors, floor_index)
  8.times do |i|
    next unless on?(floors, floor_index, false, i)

    has_matching_generator = on?(floors, floor_index, true, i)
    next if has_matching_generator

    has_other_generator = (0..7).any? { |j| i != j && on?(floors, floor_index, true, j) }
    return false if has_other_generator
  end
  true
end

def mask(*args)
  1_u64 << shift(*args)
end

def shift(floor_index, generator, id)
  shift(floor_index, (generator == true || generator == 1 ? 1 : 0) * 8 + id)
end

def shift(floor_index, generator_plus_id)
  (floor_index * 16 + generator_plus_id)
end

def on?(floors, *args)
  floors & mask(*args) != 0
end

def win?(floors)
  (floors & 0x0000FFFFFFFFFFFF) == 0
end

name_to_id = Hash(String, Int32).new { |h, k| h[k] = h.size }

# Represent all floors as 64 bits.
# Each floor is represented by 16 bits.
# Each floor is split in two: 8 bits for microchips, 8 for generators.
# Each individual bit of this split is for an element.
floors = 0_u64
input.each_line.with_index do |line, floor_index|
  line.scan(/(\w+)(?:-compatible)? (microchip|generator)/).map do |match|
    id = name_to_id[match[1]]
    generator = match[2] == "generator"
    floors |= mask(floor_index, generator, id)
  end
end

steps = Deque{ {floors, 0, 0} }
visited = Set{ {floors, 0} }
indices = [] of Int32

dist = nil
while pos = steps.shift?
  floors, elevator, dist = pos
  break if win?(floors)

  indices.clear
  16.times do |i|
    indices << i if on?(floors, elevator, i)
  end

  {2, 1}.each do |amount|
    indices.each_combination(amount) do |pieces|
      {1, -1}.each do |delta|
        next unless 0 <= elevator + delta <= 3

        copy = floors
        next_elevator = elevator + delta

        pieces.each do |piece|
          copy &= ~mask(elevator, piece)
          copy |= mask(next_elevator, piece)
        end

        next if visited.includes?({copy, next_elevator})
        next unless valid?(copy, elevator) && valid?(copy, next_elevator)

        visited << {copy, next_elevator}
        steps << {copy, next_elevator, dist + 1}
      end
    end
  end
end

if win?(floors)
  p dist
end
