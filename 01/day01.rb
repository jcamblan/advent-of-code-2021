# frozen_string_literal: true

# Day 1: Sonar Sweep
class Day01
  def initialize(input = nil)
    input ||= File.open('./01/input.txt').read
    @values = input.lines.map(&:to_i)
  end

  def part1
    count_increasing_values(@values)
  end

  def part2
    grouped_inputs = @values.each_cons(3).map(&:sum)
    count_increasing_values(grouped_inputs)
  end

  private

  def count_increasing_values(array)
    array.each_cons(2).count { |previous_value, value| previous_value < value }
  end
end
