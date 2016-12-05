require "crypto/md5"

input = "uqwqemis"

chars = [] of Char
(0..Int32::MAX).each do |i|
  text = "#{input}#{i}"
  md5 = Crypto::MD5.hex_digest(text)
  next unless md5.starts_with?("00000")

  chars << md5[5]
  break if chars.size == 8
end
puts chars.join
