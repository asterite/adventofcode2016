require "crypto/md5"

input = "qljzarfv"
steps = Deque{ {0, 0, input, 0} }
max = 0
while pos = steps.shift?
  x, y, string, dist = pos

  hash = Crypto::MD5.hex_digest(string)
  opens = hash[0...4].chars.map &.>= 'b'

  { {'U', 0, -1},
    {'D', 0, 1},
    {'L', -1, 0},
    {'R', 1, 0},
  }.each_with_index do |(char, dx, dy), index|
    next unless opens[index] && 0 <= x + dx < 4 && 0 <= y + dy < 4

    if x + dx == 3 && y + dy == 3
      max = dist + 1 if dist + 1 > max
      next
    end

    steps << {x + dx, y + dy, string + char, dist + 1}
  end
end

puts max
