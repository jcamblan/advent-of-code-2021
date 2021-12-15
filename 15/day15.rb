# frozen_string_literal: true

require 'set'
require 'pqueue'

# This resolution is largely inspired by Reddit solutions
# I was unable to resolve it by myself even after finding the right
# algorithm to use.
# I know nothing

# Day 15: Chiton
class Day15
  def initialize(input = nil)
    raw = input || File.open('./15/input.txt').read
    @cave = raw.lines(chomp: true).map { |l| l.chars.map(&:to_i) }
    @start = [0, 0]
  end

  NEAR_NODES = [
    [1, 0],
    [0, 1],
    [-1, 0],
    [0, -1]
  ].freeze

  def part1
    closest_path(@cave)
  end

  def part2
    closest_path(full_size_cave)
  end

  private

  def closest_path(cave)
    goal = [cave.size - 1, cave.first.size - 1]
    visited_nodes = Set.new
    initial = [@start, 0]
    queue = PQueue.new([initial]) { |a, b| a.last < b.last }

    loop do
      node, risk = queue.pop
      next unless visited_nodes.add?(node)
      return risk if node == goal

      fill_queue_with_valid_steps(cave, queue, risk, goal, *node)
    end
  end

  def fill_queue_with_valid_steps(cave, queue, risk, goal, *node)
    possible_next_steps(goal, *node).each do |x, y|
      queue.push([[x, y], risk + cave[y][x]])
    end
  end

  def possible_next_steps(goal, nodex, nodey)
    NEAR_NODES
      .map { |dx, dy| [dx + nodex, dy + nodey] }
      .select { |nx, ny| (0..goal[0]).include?(nx) && (0..goal[1]).include?(ny) }
  end

  def full_size_cave
    5.times.flat_map do |ny|
      @cave.map do |row|
        5.times.flat_map do |nx|
          row.map do |risk|
            new_risk = risk + ny + nx
            new_risk > 9 ? new_risk - 9 : new_risk
          end
        end
      end
    end
  end
end
