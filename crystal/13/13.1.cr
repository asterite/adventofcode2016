record Position, x : Int32, y : Int32, distance : Int32

input = 1362
walls = Hash({Int32, Int32}, Bool).new do |h, (x, y)|
  next true if x < 0 || y < 0
  h[{x, y}] = (x*x + 3*x + 2*x*y + y + y*y + input).popcount.odd?
end

steps = Deque{Position.new(1, 1, 0)}
visited = Set{ {1, 1} }

dist = nil
while pos = steps.shift?
  x, y, dist = pos.x, pos.y, pos.distance
  break if x == 31 && y == 39

  {
    {x + 1, y}, {x - 1, y},
    {x, y + 1}, {x, y - 1},
  }.each do |point|
    next if visited.includes?(point) || walls[point]
    visited << point
    steps.push Position.new(*point, dist + 1)
  end
end
puts dist
