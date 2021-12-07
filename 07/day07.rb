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

  def part2; end
end
