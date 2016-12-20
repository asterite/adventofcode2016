input = File.read("#{__DIR__}/../../inputs/20")

ranges = input.each_line.map(&.split('-').map(&.to_u64)).to_a
ranges.sort!

min = 0
ranges.each do |(left, right)|
  min = right + 1 if left <= min <= right
end
puts min
