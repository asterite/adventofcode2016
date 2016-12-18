input = "^^.^..^.....^..^..^^...^^.^....^^^.^.^^....^.^^^...^^^^.^^^^.^..^^^^.^^.^.^.^.^.^^...^^..^^^..^.^^^^"

row = input.chars
safe = row.count { |c| c == '.' }

next_row = Array.new(row.size, '.')

(40 - 1).times do
  row.size.times do |i|
    left = i == 0 ? '.' : row[i - 1]
    right = i == row.size - 1 ? '.' : row[i + 1]
    next_row[i] = left == right ? '.' : '^'
  end
  row, next_row = next_row, row
  safe += row.count { |c| c == '.' }
end

puts safe
