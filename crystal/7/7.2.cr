input = File.read("#{__DIR__}/../../inputs/7")

count = 0
input.each_line do |line|
  outs = [] of String
  insides = [] of String

  line.scan(/(?:(\w+))?(?:\[(\w+)\])?/) do |match|
    outside = match[1]?
    inside = match[2]?

    outs << outside if outside
    insides << inside if inside
  end

  ssl = outs.any? do |o|
    (0..o.size - 3).any? do |x|
      o[x] != o[x + 1] && o[x] == o[x + 2] &&
        insides.any? do |i|
          (0..i.size - 3).any? do |y|
            i[y] == o[x + 1] == i[y + 2] && i[y + 1] == o[x]
          end
        end
    end
  end

  count += 1 if ssl
end
puts count
