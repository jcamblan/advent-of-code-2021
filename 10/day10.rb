# frozen_string_literal: true

# Day 10: Syntax Scoring
class Day10
  def initialize(input = nil)
    raw = input || File.open('./10/input.txt').read
    input = raw.lines(chomp: true).map(&:chars)
    @nav_sub = NavigationSubsystem.new(input)
  end

  def part1
    @nav_sub.breaking_score
  end

  def part2
    @nav_sub.middle_score
  end
end

# Manage the Navigation Subsystem
class NavigationSubsystem
  def initialize(input)
    @input = input
  end

  def lines
    @lines ||= @input.map do |line|
      LogLine.new(line).parse
    end
  end

  def incomplete_lines
    lines.select { !_1.breaking_score }
  end

  def breaking_score
    lines.filter_map(&:breaking_score).sum
  end

  def incomplete_scores
    incomplete_lines.filter_map(&:incomplete_score)
  end

  def middle_score
    sorted = incomplete_scores.sort
    size = sorted.count
    center = size / 2
    size.even? ? (sorted[center] + sorted[center + 1]) / 2 : sorted[center]
  end
end

# Navigation Subsystem log line
class LogLine
  OPENERS = ['(', '[', '{', '<'].freeze
  CLOSERS = [')', ']', '}', '>'].freeze

  POINTS = {
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25_137
  }.freeze

  def initialize(input)
    @input = input
    @accepted_closers = []
    @breaking_char = nil
  end

  def parse
    @input.each do |symbol|
      parse_input(symbol)
      break if @breaking_char
    end

    self
  end

  def parse_input(symbol)
    if OPENERS.include?(symbol)
      @accepted_closers << CLOSERS[OPENERS.index(symbol)]
    elsif CLOSERS.include?(symbol) && @accepted_closers[-1] == symbol
      @accepted_closers.pop
    else
      @breaking_char = symbol
    end
  end

  def missing_closers
    @accepted_closers.reverse
  end

  def breaking_score
    POINTS[@breaking_char]
  end

  def incomplete_score
    score = 0
    missing_closers.each do |closer|
      score = score * 5 + CLOSERS.index(closer) + 1
    end

    score
  end
end
