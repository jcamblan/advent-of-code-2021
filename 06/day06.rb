# frozen_string_literal: true

# Day 6: Lanternfish
class Day06
  def initialize(input = nil)
    @input = input || File.open('./06/input.txt').read
    @fishs = @input.split(',').map(&:to_i).group_by(&:itself)
                   .map { [_1, _2.count] }.to_h
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
    @fishs = @fishs.each_with_object(empty_fish_list) do |prev, new_hash|
      new_state = prev[0].zero? ? 6 : prev[0] - 1
      new_hash[new_state] += prev[1]
      new_hash[8] += prev[1] if prev[0].zero?
    end
  end

  def empty_fish_list
    (0..8).zip([0] * 9).to_h
  end
end
