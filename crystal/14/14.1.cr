require "crypto/md5"

struct Table
  def initialize(@salt : String)
    @table = Hash(Int32, {Char?, Array(Char)}).new
  end

  def check(index)
    @table[index] ||= begin
      str = Crypto::MD5.hex_digest("#{@salt}#{index}")
      threes = str.scan(/(.)\1\1/)
      three = threes.empty? ? nil : threes.first[0][0]
      fives = str.scan(/(.)\1\1\1\1/).map &.[0][0]
      {three, fives}
    end
  end

  def check3(index)
    check(index).try &.[0]
  end

  def check5(index, char)
    check(index).try &.[1].includes?(char)
  end
end

salt = "ahsbgdzn"
table = Table.new(salt)
total = 0

loop do |i|
  if char = table.check3(i)
    if (i + 1..i + 1000).any? { |j| table.check5(j, char) }
      total += 1
      if total == 64
        puts i
        break
      end
    end
  end
end
