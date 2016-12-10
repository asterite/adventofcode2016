input = File.read("#{__DIR__}/../../inputs/10")

record Instruction, output : Bool, value : Int32

bots = Hash(Int32, Array(Int32)).new { |h, k| h[k] = [] of Int32 }
output = {} of Int32 => Int32
instructions = {} of Int32 => {Instruction, Instruction}

input.each_line do |line|
  case line
  when /value (\d+) goes to bot (\d+)/
    bots[$2.to_i] << $1.to_i
  when /bot (\d+) gives low to (bot|output) (\d+) and high to (bot|output) (\d+)/
    instructions[$1.to_i] = {
      Instruction.new($2 == "output", $3.to_i),
      Instruction.new($4 == "output", $5.to_i),
    }
  end
end

result = nil
target = [17, 61]
loop do
  executed = false
  bots.each do |bot_number, bot|
    if bot.size == 2 && (pair = instructions[bot_number]?)
      executed = true
      values = bot.sort
      bots[bot_number].clear

      result ||= bot_number if values == target

      pair.each_with_index do |ins, i|
        value = values[i]
        if ins.output
          output[ins.value] = value
        else
          bots[ins.value] << value
        end
      end
    end
  end
  break unless executed
end

p result
p output[0] * output[1] * output[2]
