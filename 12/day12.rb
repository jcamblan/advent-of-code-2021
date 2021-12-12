# frozen_string_literal: true

# Day 11: Dumbo Octopus
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

  def add_paths(from, previous_steps)
    @segments.select { |link| link.include?(from) }.each do |seg|
      target = target_value(from, seg)

      @possible_paths_count += 1 if target == 'end'
      next if target.match?(/^[a-z]+$/) && previous_steps.include?(target)

      new_steps = previous_steps.dup.flatten.push(target)

      add_paths(target, new_steps) unless target == 'end'
    end
  end

  def part2; end

  def target_value(from, array)
    (array - [from])[0]
  end
end
