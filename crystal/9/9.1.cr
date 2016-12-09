require "string_scanner"

def decompressed_length(input, level = 0)
  total = 0_i64
  scanner = StringScanner.new(input)
  until scanner.eos?
    case scanner
    when .scan(/\((\d+)x(\d+)\)/)
      count = scanner[1].to_i
      amount = scanner[2].to_i
      chunk = input[scanner.offset, count].gsub(/\s/, "")
      total += chunk.size * amount
      scanner.offset += count
    when .scan(/[^\(]+/)
      total += scanner[0].gsub(/\s/, "").size
    end
  end
  total
end

input = File.read("#{__DIR__}/../../inputs/9")

puts decompressed_length(input)
