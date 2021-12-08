# frozen_string_literal: true

# Day 8: Seven Segment Search
class Day08
  def initialize(input = nil)
    @input = input || File.open('./08/input.txt').read
  end

  EZ_SEGMENTS = { 2 => 1, 4 => 4, 3 => 7, 7 => 8 }.freeze

  NUMBERS = {
    %w[a b c e f g] => 0,
    %w[c f] => 1,
    %w[a c d e g] => 2,
    %w[a c d f g] => 3,
    %w[b c d f] => 4,
    %w[a b d f g] => 5,
    %w[a b d e f g] => 6,
    %w[a c f] => 7,
    %w[a b c d e f g] => 8,
    %w[a b c d f g] => 9
  }.freeze

  #   0:      1:      2:      3:      4:
  #  aaaa    ....    aaaa    aaaa    ....
  # b    c  .    c  .    c  .    c  b    c
  # b    c  .    c  .    c  .    c  b    c
  #  ....    ....    dddd    dddd    dddd
  # e    f  .    f  e    .  .    f  .    f
  # e    f  .    f  e    .  .    f  .    f
  #  gggg    ....    gggg    gggg    ....
  #
  #   5:      6:      7:      8:      9:
  #  aaaa    aaaa    aaaa    aaaa    aaaa
  # b    .  b    .  .    c  b    c  b    c
  # b    .  b    .  .    c  b    c  b    c
  #  dddd    dddd    ....    dddd    dddd
  # .    f  e    f  .    f  e    f  .    f
  # .    f  e    f  .    f  e    f  .    f
  #  gggg    gggg    ....    gggg    gggg

  def part1
    outputs = @input.lines.map { _1.split(' | ')[1].split }
    outputs.flatten.count { EZ_SEGMENTS[_1.length] }
  end

  def part2
    @lines = @input.lines.map { _1.split(' | ').map(&:split) }
    @lines.map do |signal_pattern, output|
      @signal_pattern = signal_pattern
      translate(output)
    end.sum
  end

  private

  def translate(output)
    # been block without any understanding for hours on part 2 because here I wrote @values[char] 😭
    output.map { |digits| NUMBERS[digits.chars.map { |char| values.invert[char] }.sort].to_s }.join.to_i
  end

  def values
    abcdf_values.merge(ge_values)
  end

  def abcdf_values
    {
      'a' => (ez_numbers[7] - ez_numbers[1]).first,
      'c' => find_by_recurrency(ez_numbers[1], 8),
      'f' => find_by_recurrency(ez_numbers[1], 9),
      'b' => find_by_recurrency(bd_chars, 6),
      'd' => find_by_recurrency(bd_chars, 7)
    }
  end

  def ge_values
    {
      'g' => g_char,
      'e' => (%w[a b c d e f g] - abcdf_values.values.flatten - [g_char]).last
    }
  end

  # return the entry from selection that appears the given amount of times in the entire signal pattern
  def find_by_recurrency(array, count)
    array.find { @signal_pattern.join.count(_1) == count }
  end

  # 1, 4, 7 and 8 are easy to isolate because of their unique amount of segments
  def ez_numbers
    @signal_pattern.filter_map do |digits|
      [EZ_SEGMENTS[digits.length], digits.chars] if EZ_SEGMENTS[digits.length]
    end.to_h
  end

  # b and d segments can be deducted easily from 1 and 4 values
  def bd_chars
    (ez_numbers[4] - ez_numbers[1])
  end

  # once we got values from a, b, c, d & f, we can easily deduce the value of g
  # thanks to digit nine that is the only one to include all of those segments
  def g_char
    nine = @signal_pattern.find { (abcdf_values.values.flatten - _1.chars).empty? && _1.length == 6 }
    (nine.chars - abcdf_values.values.flatten).first
  end
end
