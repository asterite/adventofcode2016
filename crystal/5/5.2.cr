require "crypto/md5"

input = "abc"

chars = Array.new(8, '_')
found = Set(Int32).new
(0..Int32::MAX).each do |i|
  text = "#{input}#{i}"
  md5 = Crypto::MD5.hex_digest(text)
  next unless md5.starts_with?("00000")

  position = md5[5].to_i?.try &.to_i32
  next unless position && position < 8

  next if found.includes?(position)
  found << position

  char = md5[6]
  chars[position] = char
  break if found.size == 8
end
puts chars.join
