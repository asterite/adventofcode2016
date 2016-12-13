input = File.read("#{__DIR__}/../../inputs/12")

record Copy, value : Int32 | String, target : String
record Inc, register : String
record Dec, register : String
record Jnz, register : Int32 | String, away : Int32
alias Instruction = Copy | Inc | Dec | Jnz

instructions = [] of Instruction
registers = {
  "a" => 0,
  "b" => 0,
  "c" => 0,
  "d" => 0,
}

input.each_line do |line|
  case line
  when /cpy (.+) (.+)/
    instructions << Copy.new($1.to_i? || $1, $2)
  when /inc (.+)/
    instructions << Inc.new($1)
  when /dec (.+)/
    instructions << Dec.new($1)
  when /jnz (.+) (.+)/
    instructions << Jnz.new($1.to_i? || $1, $2.to_i)
  end
end

ip = 0
while ip < instructions.size
  case inst = instructions[ip]
  when Copy
    value = inst.value
    value = value.is_a?(String) ? registers[value] : value
    registers[inst.target] = value
  when Inc
    registers[inst.register] += 1
  when Dec
    registers[inst.register] -= 1
  when Jnz
    reg = inst.register
    value = reg.is_a?(String) ? registers[reg] : reg
    if value != 0
      ip += inst.away
      next
    end
  end
  ip += 1
end

p registers["a"]
