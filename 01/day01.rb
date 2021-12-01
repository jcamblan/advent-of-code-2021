class Day01
  def initialize
    input = File.open('./01/input.txt').read
    @values = input.lines.map(&:to_i)
  end

  def solution
    @values.each_cons(2).count { |previous_value, value| previous_value < value }
  end
end