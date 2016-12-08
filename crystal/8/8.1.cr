input = File.read("#{__DIR__}/../../inputs/8")

display = Array.new(6) { Array.new(50, '.') }

input.each_line do |line|
  puts "=" * 80
  puts line
  case line
  when /rect (\d+)x(\d+)/
    w, h = $1.to_i, $2.to_i
    h.times do |y|
      w.times do |x|
        display[y][x] = '#'
      end
    end
  when /rotate column x=(\d+) by (\d+)/
    c, a = $1.to_i, $2.to_i
    a.times do
      t = display[-1][c]
      (display.size - 1).downto(0) do |y|
        display[y][c] = y == 0 ? t : display[y - 1][c]
      end
    end
  when /rotate row y=(\d+) by (\d+)/
    r, a = $1.to_i, $2.to_i
    display[r].rotate!(-a)
  end

  display.each do |row|
    puts row.join
  end
end

puts display.sum &.count &.==('#')
