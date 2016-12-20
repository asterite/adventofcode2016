elves = Deque.new((1..3005290).to_a)
(elves.size - 1).times do
  elves.push(elves.shift)
  elves.shift
end
puts elves.first
