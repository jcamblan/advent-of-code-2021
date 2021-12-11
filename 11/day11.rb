# frozen_string_literal: true

# Day 11: Dumbo Octopus
class Day11
  def initialize(input = nil)
    raw = input || File.open('./11/input.txt').read
    @matrix = raw.lines(chomp: true).map { _1.chars.map(&:to_i)}
    @flashes = 0
  end

  def part1
    100.times { process_step! }
    @flashes
  end

  def part2; end

  def process_step!
    @matrix.each.with_index do |line, y|
      line.each.with_index do |_, x|
        @matrix[y][x] += 1

        flash!(y, x) if @matrix[y][x] == 10
      end
    end

    flush_flashed!
  end

  def flash!(*coords)
    borders(*coords).each do |y, x|
      @matrix[y][x] += 1

      flash!(y, x) if @matrix[y][x] == 10
    end

    @flashes += 1
  end

  def flush_flashed!
    @matrix.each.with_index do |line, y|
      line.each.with_index do |_octopus, x|
        @matrix[y][x] = 0 if @matrix[y][x] >= 10
      end
    end
  end

  def borders(y_pos, x_pos)
    [
      [-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1]
    ].filter_map do |v, h|
      ny = y_pos + v
      nx = x_pos + h
      [ny, nx] if @matrix.dig(ny, nx) && !nx.negative? && !ny.negative?
    end
  end
end
