# frozen_string_literal: true

# Day 8: Seven Segment Search
class Day08
  def initialize(input = nil)
    @input = input || File.open('./08/input.txt').read
  end

  EZ_SEGMENTS = { 2 => 1, 4 => 4, 3 => 7, 7 => 8 }.freeze

  def part1
    outputs = @input.lines.map { _1.split(' | ')[1].split }
    outputs.flatten.count { EZ_SEGMENTS[_1.length] }
  end

  def part2; end
end
