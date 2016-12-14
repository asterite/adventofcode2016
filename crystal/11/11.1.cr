# Takes 2 seconds to complete

input = File.read("#{__DIR__}/../../inputs/11")

record Piece, elem : Int32, generator : Bool do
  include Comparable(Piece)

  def <=>(other : Piece)
    x = elem <=> other.elem
    x = generator.hash <=> other.generator.hash if x == 0
    x
  end
end

def valid?(floor)
  floor.each do |piece|
    next if piece.generator

    has_matching_generator =
      floor.any? { |other| other.elem == piece.elem && other.generator }
    next if has_matching_generator

    has_other_generator =
      floor.any? { |other| other.elem != piece.elem && other.generator }
    return false if has_other_generator
  end
  true
end

def win?(floors)
  (0..2).all? { |i| floors[i].empty? }
end

name_to_id = Hash(String, Int32).new { |h, k| h[k] = h.size }

floors = input.each_line.map do |line|
  line.scan(/(\w+)(?:-compatible)? (microchip|generator)/).map do |match|
    Piece.new(name_to_id[match[1]], match[2] == "generator")
  end
end.to_a

floors.each &.sort!

steps = Deque{ {floors, 0, 0} }
visited = Set{ {floors, 0} }

dist = nil
while pos = steps.shift?
  floors, elevator, dist = pos
  break if win?(floors)

  {2, 1}.each do |amount|
    floors[elevator].each_combination(amount) do |pieces|
      {1, -1}.each do |delta|
        next unless 0 <= elevator + delta <= 3

        copy = floors.clone

        next_elevator = elevator + delta
        pieces.each do |piece|
          copy[elevator].delete(piece)
          copy[next_elevator] << piece
        end

        copy[elevator].sort!
        copy[next_elevator].sort!

        next if visited.includes?({copy, next_elevator})
        next unless valid?(copy[elevator]) && valid?(copy[next_elevator])

        visited << {copy, next_elevator}
        steps << {copy, next_elevator, dist + 1}
      end
    end
  end
end

if win?(floors)
  p dist
end
