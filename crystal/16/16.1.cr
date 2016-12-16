input = "10001001100000001"
length = 272

a = input.each_char.map { |c| c == '1' }.to_a
while a.size < length
  b = a.reverse.map { |x| !x }
  a = a + [false] + b
end
a = a.first(length)

checksum = a
loop do
  checksum = checksum.each_slice(2).map { |(x, y)| x == y }.to_a
  break if checksum.size.odd?
end
puts checksum.map { |x| x ? '1' : '0'}.join
