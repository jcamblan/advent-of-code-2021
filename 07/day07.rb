# frozen_string_literal: true

# Day 7: The Treachery of Whales
class Day07
  def initialize(input = nil)
    @input = input || File.open('./07/input.txt').read
    @positions = @input.split(',').map(&:to_i)
  end

  def part1
    Range.new(@positions.min, @positions.max).map { |goal| @positions.map {(_1 - goal).abs }.sum }.min
  end

  def part2
    Range.new(@positions.min, @positions.max).map do |goal|
      @positions.map do |pos|
        abs = (pos - goal).abs
        (abs / 2.0 * (1 + abs)).to_i
      end.sum
    end.min
  end
end
