input = File.read("#{__DIR__}/../../inputs/3")

count = input.each_line.count do |line|
  a, b, c = line.split.map(&.to_i)
  (a + b > c) && (a + c > b) && (b + c > a)
end
puts count
