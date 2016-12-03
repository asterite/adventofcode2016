input = File.read("#{__DIR__}/../../inputs/2")

x = nil
A = 'A'
B = 'B'
C = 'C'
D = 'D'

pad = [
  [x, x, 1, x, x],
  [x, 2, 3, 4, x],
  [5, 6, 7, 8, 9],
  [x, A, B, C, x],
  [x, x, D, x, x],
]

x = 0
y = 2

code = input.each_line.join do |line|
  line.each_char do |char|
    case char
    when 'U'
      ny = {y - 1, 0}.max
      y = ny if pad[ny][x]
    when 'D'
      ny = {y + 1, 4}.min
      y = ny if pad[ny][x]
    when 'L'
      nx = {x - 1, 0}.max
      x = nx if pad[y][nx]
    when 'R'
      nx = {x + 1, 4}.min
      x = nx if pad[y][nx]
    end
  end
  pad[y][x]
end

puts code
