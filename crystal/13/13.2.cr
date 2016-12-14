def wall?(x, y)
  x < 0 || y < 0 || (x*x + 3*x + 2*x*y + y + y*y + 1362).popcount.odd?
end

steps = Deque{ {1, 1, 0} }
visited = Set{ {1, 1} }

total = 0
while pos = steps.shift?
  x, y, dist = pos
  break if dist == 51

  total += 1

  {
    {x + 1, y}, {x - 1, y},
    {x, y + 1}, {x, y - 1},
  }.each do |point|
    next if visited.includes?(point) || wall?(*point)
    visited << point
    steps.push({point[0], point[1], dist + 1})
  end
end
puts total
