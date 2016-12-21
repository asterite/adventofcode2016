input = File.read("#{__DIR__}/../../inputs/21")

chars = "abcdefgh".chars
input.each_line do |line|
  case line
  when /swap position (\d) with position (\d)/
    x, y = $1.to_i, $2.to_i
    chars.swap(x, y)
  when /swap letter (\w) with letter (\w)/
    x, y = $1.to_s[0], $2.to_s[0]
    chars.map! { |c| c == x ? y : (c == y ? x : c) }
  when /reverse positions (\d) through (\d)/
    from, to = $1.to_i, $2.to_i
    while from < to
      chars.swap(from, to)
      from += 1
      to -= 1
    end
  when /rotate (left|right) (\d+) steps?/
    sign = $1.to_s == "left" ? 1 : -1
    steps = $2.to_i
    chars.rotate!(sign * steps)
  when /move position (\d) to position (\d)/
    from, to = $1.to_i, $2.to_i
    char = chars.delete_at(from)
    chars.insert(to, char)
  when /rotate based on position of letter (\w)/
    letter = $1.to_s[0]
    index = chars.index(letter).not_nil!
    chars.rotate!(-(1 + index + (index >= 4 ? 1 : 0)))
  end
end
puts chars.join
