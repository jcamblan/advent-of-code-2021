# frozen_string_literal: true

# Day 2: Dive!
class Day03
  def initialize(input = nil)
    input ||= File.open('./03/input.txt').read
    @numbers = input.lines.map(&:chomp).map(&:chars)
  end

  def part1
    @matrix = @numbers.transpose
    gamma_rate * espilon_rate
  end

  def part2
    oxygen_generator_rating * co2_scrubber_rating
  end

  private

  def oxygen_generator_rating
    rating(ogr_bit_criteria)
  end

  def co2_scrubber_rating
    rating(co2sr_bit_criteria)
  end

  def rating(criteria)
    numbers = @numbers.dup
    @numbers.each_with_index do |_, i|
      numbers = numbers.select do |number|
        number[i] == criteria.call(numbers.transpose[i])
      end
      break if numbers.size == 1
    end

    numbers.first.join.to_i(2)
  end

  def gamma_rate
    @matrix.map do |row|
      row.max_by { |bit| row.count(bit) }
    end.join.to_i(2)
  end

  def espilon_rate
    @matrix.map do |row|
      row.min_by { |bit| row.count(bit) }
    end.join.to_i(2)
  end

  def ogr_bit_criteria
    proc { |array| array.count('1') >= array.size.to_f / 2 ? '1' : '0' }
  end

  def co2sr_bit_criteria
    proc { |array| array.count('0') <= array.size.to_f / 2 ? '0' : '1' }
  end
end
