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
      fill_values(signal_pattern)

      translate_output(output)
    end.sum
  end

  def fill_values(signal_pattern)
    numbers = {}
    values = {}

    signal_pattern.each do |digits|
      numbers[EZ_SEGMENTS[digits.length]] = digits.chars if EZ_SEGMENTS[digits.length]
    end

    values['a'] = (numbers[7] - numbers[1]).first
    values['c'] = numbers[1].find { signal_pattern.join.count(_1) == 8 }
    values['f'] = numbers[1].find { signal_pattern.join.count(_1) == 9 }
    values['b'] = (numbers[4] - numbers[1]).find { signal_pattern.join.count(_1) == 6 }
    values['d'] = (numbers[4] - numbers[1]).find { signal_pattern.join.count(_1) == 7 }

    abcdf = values.select { |k, _| %w[a b c d f].include?(k) }.values.flatten
    nine = signal_pattern.find do |n|
      abcdf.all? { n.chars.include?(_1) } && n.length == 6
    end

    values['g'] = (nine.chars - abcdf).first
    values['e'] = (%w[a b c d e f g] - values.values.flatten).last

    @values = values
  end

  def translate_output(output)
    # been block without any understanding for hours on part 2 because here I wrote @values[char] 😭
    output.map { |digits| NUMBERS[digits.chars.map { |char| @values.invert[char] }.sort].to_s }.join.to_i
  end
end
