elves = 3005290
left = Deque.new((1..elves / 2).to_a)
right = Deque.new(((elves / 2 + 1)..elves).to_a)

(elves - 1).times do
  if left.size > right.size
    left.pop
  else
    right.shift
  end
  right.push(left.shift)
  left.push(right.shift)
end

puts (left.first? || right.first)
