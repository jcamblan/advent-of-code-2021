# frozen_string_literal: true

# Day 6: Lanternfish
class Day06
  def initialize(input = nil)
    @input = input || File.open('./06/input.txt').read
    @fishs = @input.split(',').map(&:to_i)
  end

  def part1
    80.times { one_more_day }
    @fishs.count
  end

  def part2; end

  private

  def one_more_day
    new_fishs = 0
    @fishs = @fishs.map do |state|
      if state.zero?
        new_fishs += 1
        6
      else
        state - 1
      end
    end
    new_fishs.times.each { @fishs << 8 }
  end
end
