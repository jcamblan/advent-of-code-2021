# frozen_string_literal: true

# Day 6: Lanternfish
class Day06
  def initialize(input = nil)
    @input = input || File.open('./06/input.txt').read
    @fishs = @input.split(',').map(&:to_i).tally
  end

  def part1
    80.times { one_more_day }
    @fishs.values.sum
  end

  def part2
    256.times { one_more_day }
    @fishs.values.sum
  end

  private

  def one_more_day
    @fishs = @fishs.each_with_object(Hash.new(0)) do |prev, new_hash|
      new_state = prev[0].zero? ? 6 : prev[0] - 1
      new_hash[new_state] += prev[1]
      new_hash[8] += prev[1] if prev[0].zero?
    end
  end
end
