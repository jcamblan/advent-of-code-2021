# frozen_string_literal: true

# Day 11: Dumbo Octopus
class Day11
  def initialize(input = nil)
    raw = input || File.open('./11/input.txt').read
    @octopuses = raw.lines(chomp: true).map { _1.chars.map(&:to_i)}
    @flashes = 0
    @simultaneous_flashes = false
  end

  NEIGHBOURS = ([-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]).freeze

  def part1
    100.times { process_step! }
    @flashes
  end

  def part2
    count = 0
    until @simultaneous_flashes
      process_step!
      count += 1
    end

    count
  end

  def process_step!
    @octopuses.each.with_index do |line, y|
      line.each.with_index do |_, x|
        @octopuses[y][x] += 1

        flash!(y, x) if @octopuses[y][x] == 10
      end
    end

    flush_flashed!
  end

  def flash!(*coords)
    nearby_octopuses(*coords).each do |y, x|
      @octopuses[y][x] += 1

      flash!(y, x) if @octopuses[y][x] == 10
    end

    @flashes += 1
  end

  def flush_flashed!
    @octopuses.each.with_index do |line, y|
      line.each.with_index do |_octopus, x|
        @octopuses[y][x] = 0 if @octopuses[y][x] >= 10
      end
    end

    @simultaneous_flashes = @octopuses.flatten.all?(&:zero?)
  end

  def nearby_octopuses(y_pos, x_pos)
    NEIGHBOURS.filter_map do |v, h|
      ny = y_pos + v
      nx = x_pos + h
      [ny, nx] if @octopuses.dig(ny, nx) && !nx.negative? && !ny.negative?
    end
  end
end
