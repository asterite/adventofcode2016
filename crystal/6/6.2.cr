input = File.read("#{__DIR__}/../../inputs/6")

counts = Hash(Int32, Hash(Char, Int32)).new do |h, k|
  h[k] = Hash(Char, Int32).new(0)
end
input.each_line do |line|
  line.each_char_with_index do |char, index|
    counts[index][char] += 1
  end
end

code = counts.map do |pos, hash|
  max_entry = hash.min_by { |char, count| count }
  max_entry[0]
end
puts code.join
