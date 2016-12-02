input = File.read("#{__DIR__}/../../inputs/1")
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

steps.each do |step|
  turn = step[0]
  distance = step[1..-1].to_i

  case turn
  when 'L'
    direction = (direction + 1) % 4
  when 'R'
    direction = (direction - 1) % 4
  end

  x += directions[direction][:x] * distance
  y += directions[direction][:y] * distance
end

pp x, y
puts x.abs + y.abs
