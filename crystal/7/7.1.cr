def abba?(str)
  (0..str.size - 4).any? do |i|
    str[i] != str[i + 1] &&
      str[i] == str[i + 3] &&
      str[i + 1] == str[i + 2]
  end
end

input = File.read("#{__DIR__}/../../inputs/7")

count = 0
input.each_line do |line|
  any_outside = false
  none_inside = true

  line.scan(/(?:(\w+))?(?:\[(\w+)\])?/) do |match|
    outside = match[1]?
    inside = match[2]?

    if outside
      any_outside ||= abba?(outside)
    end

    if inside && abba?(inside)
      none_inside = false
      break
    end
  end

  count += 1 if any_outside && none_inside
end
puts count
