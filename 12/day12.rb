# frozen_string_literal: true

# Day 12: Passage Pathing
class Day12
  def initialize(input = nil)
    raw = input || File.open('./12/input.txt').read
    @segments = raw.lines(chomp: true).map { _1.split('-')}
    @possible_paths_count = 0
  end

  def part1
    add_paths('start', ['start'])
    @possible_paths_count
  end

  def part2
    add_paths('start', ['start'], twice: true)
    @possible_paths_count
  end

  def add_paths(from, previous_steps, twice: false)
    @segments.select { |link| link.include?(from) }.each do |seg|
      target = target_value(from, seg)

      @possible_paths_count += 1 if target.end?

      next if invalid_target?(target, previous_steps, twice)

      add_paths(target, previous_steps.dup.push(target), twice: twice) unless target.end?
    end
  end

  def target_value(from, array)
    (array - [from])[0]
  end

  def invalid_target?(target, previous_steps, twice)
    return true if duplicated_endpoint?(target, previous_steps)
    return true if twiced?(previous_steps) && duplicated_small_cave?(target, previous_steps)

    !twice && duplicated_small_cave?(target, previous_steps)
  end

  def duplicated_small_cave?(target, previous_steps)
    target.small_cave? && previous_steps.include?(target)
  end

  def duplicated_endpoint?(target, previous_steps)
    target.endpoint? && previous_steps.include?(target)
  end

  def twiced?(previous_steps)
    previous_steps.tally.any? { |k, v| k.small_cave? && v > 1 }
  end
end

# Overwrite String with helpers in order to lighten the logic up here
class String
  def small_cave?
    match?(/^[a-z]+$/) && !endpoint?
  end

  def start?
    self == 'start'
  end

  def end?
    self == 'end'
  end

  def endpoint?
    self == 'start' || self == 'end'
  end
end
