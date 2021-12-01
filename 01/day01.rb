class Day01
  def initialize
    input = File.open('./01/input.txt').read
    @values = input.lines.map(&:to_i)
  end

  def solution
    { "1" => part1, "2" => part2 }
  end

  private

  def part1
    count_increasing_values(@values)
  end

  def part2
    grouped_inputs = @values.each_cons(3).map(&:sum)
    count_increasing_values(grouped_inputs)
  end

  def count_increasing_values(array)
    array.each_cons(2).count { |previous_value, value| previous_value < value }
  end
end