require "crypto/md5"

input = "qljzarfv"

steps = Deque{ {0, 0, input, 0} }
visited = Set{ {0, 0, input} }

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
    open = opens[index]
    next unless open

    nx = x + dx
    next unless 0 <= nx < 4

    ny = y + dy
    next unless 0 <= ny < 4

    if nx == 3 && ny == 3
      max = dist + 1 if dist + 1 > max
      next
    end

    nstring = string + char
    next if visited.includes?({nx, ny, nstring})

    visited << {nx, ny, nstring}
    steps << {nx, ny, nstring, dist + 1}
  end
end

puts max
