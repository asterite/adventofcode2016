input = File.read("#{__DIR__}/../../inputs/2")

pad = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
]

x = 1
y = 1

code = input.each_line.join do |line|
  line.each_char do |char|
    case char
    when 'U'
      y = {y - 1, 0}.max
    when 'D'
      y = {y + 1, 2}.min
    when 'L'
      x = {x - 1, 0}.max
    when 'R'
      x = {x + 1, 2}.min
    end
  end
  pad[y][x]
end

puts code
