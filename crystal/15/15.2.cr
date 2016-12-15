input = File.read("#{__DIR__}/../../inputs/15")

record Disc, positions : Int32, position : Int32

discs = input.lines.map do |line|
  line =~ /Disc #\d+ has (\d+) positions; at time=0, it is at position (\d+)/
  Disc.new($1.to_i, $2.to_i)
end
discs << Disc.new(11, 0)

answer = (1..Int32::MAX).find do |time|
  discs.each_with_index.all? do |disc, index|
    (time + 1 + index + disc.position).divisible_by?(disc.positions)
  end
end
p answer
