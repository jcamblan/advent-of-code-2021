# frozen_string_literal: true

require 'pry'
# Day 5: Hydrothermal Venture
class Day05
  def initialize(input = nil)
    @input = input || File.open('./05/input.txt').read
    @lines = @input.lines.map do |l|
      l.split(' -> ').map { |coord| coord.split(',').map(&:to_i) }
    end
  end

  def part1
    values = @lines.filter_map { |line| points(line) }.flatten
    values.group_by(&:itself).count { |_, v| v.count > 1 }
  end

  def part2; end

  private

  def points(line)
    x, y = line.transpose.map(&:sort)

    if x.uniq.size == 1
      Range.new(*y).map { |i| "#{x[0]},#{i}" }
    elsif y.uniq.size == 1
      Range.new(*x).map { |i| "#{i},#{y[0]}" }
    end
  end
end
