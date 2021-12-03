# frozen_string_literal: true

# Day 2: Dive!
class Day03
  def initialize(input = nil)
    input ||= File.open('./03/input.txt').read
    @matrix = input.lines.map(&:chomp).map(&:chars).transpose
  end

  def part1
    gamma_rate * espilon_rate
  end

  def part2; end

  private

  def gamma_rate
    binary_to_integer(
      @matrix.map do |row|
        row.max_by { |bit| row.count(bit) }
      end.join
    )
  end

  def espilon_rate
    binary_to_integer(
      @matrix.map do |row|
        row.min_by { |bit| row.count(bit) }
      end.join
    )
  end

  def binary_to_integer(binary)
    binary.reverse.chars.filter_map.with_index do |bit, i|
      2**i if bit.to_i.positive?
    end.sum
  end
end
