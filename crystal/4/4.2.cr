input = File.read("#{__DIR__}/../../inputs/4")

input.each_line do |line|
  next unless line =~ /(.+?)-(\d+)\[(.+?)\]/

  letters = $1
  sector_id = $2.to_i
  checksum = $3

  # Count letters
  hash = Hash(Char, Int32).new(0)
  letters.each_char do |char|
    hash[char] += 1 if char != '-'
  end

  # Get all counts, sorted
  counts = hash.values.sort!

  # The checksum holds if the letter count for each letter
  # equals the last element in `counts` (popping it)
  matches = checksum.each_char.all? do |char|
    (v = hash[char]?) && (c = counts.pop?) && v == c
  end

  if matches
    # Decode
    real = letters.gsub do |char|
      sector_id.times do
        char = case char
               when '-', ' ' then ' '
               when 'z'      then 'a'
               else               char + 1
               end
      end
      char
    end

    if real == "northpole object storage"
      puts sector_id
      break
    end
  end
end
