input = File.read("#{__DIR__}/../../inputs/3")

count = input.each_line.each_slice(3).sum do |slice|
  slice.map(&.split.map(&.to_i)).transpose.count do |(a, b, c)|
    (a + b > c) && (a + c > b) && (b + c > a)
  end
end
puts count
