input = File.read("#{__DIR__}/../../inputs/20")

ranges = input.each_line.map(&.split('-').map(&.to_u64)).to_a
ranges.sort!

last = 0_u64
total = 0_u64
ranges.each do |(left, right)|
  total += left - last if last < left
  last = right + 1 if right + 1 > last
end
total += 4294967295 - last if last < 4294967295
puts total
