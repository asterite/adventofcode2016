input = File.read("#{__DIR__}/../../input")
steps = input.split(",").map(&.strip)

directions = [
  {x: 0, y: 1},  # North
  {x: 1, y: 0},  # East
  {x: 0, y: -1}, # South
  {x: -1, y: 0}, # West
]

x = 0
y = 0
direction = 0 # North
visited = Set{ {x, y} }

steps.each do |step|
  turn = step[0]
  distance = step[1..-1].to_i

  case turn
  when 'L'
    direction = (direction + 1) % 4
  when 'R'
    direction = (direction - 1) % 4
  end

  found = false
  distance.times do
    x += directions[direction][:x]
    y += directions[direction][:y]

    if visited.includes?({x, y})
      found = true
      break
    end
    visited << {x, y}
  end

  break if found
end

pp x, y
puts x.abs + y.abs
