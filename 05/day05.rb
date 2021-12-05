# frozen_string_literal: true

# Day 5: Hydrothermal Venture
class Day05
  def initialize(input = nil)
    @input = input || File.open('./05/input.txt').read
    @lines = @input.lines.map do |line|
      line.split(' -> ').map { |coord| coord.split(',').map(&:to_i) }
    end
  end

  def part1
    draw_lines(with_diagonals: false)
  end

  def part2
    draw_lines(with_diagonals: true)
  end

  private

  def draw_lines(with_diagonals: true)
    values = @lines.filter_map { |line| points(line, with_diagonals: with_diagonals) }.flatten
    values.group_by(&:itself).count { |_, v| v.count > 1 }
  end

  def points(line, with_diagonals: true)
    coords = line.transpose

    return horizontal(coords) if coords[0].uniq.size == 1
    return vertical(coords) if coords[1].uniq.size == 1

    diagonal(coords) if with_diagonals
  end

  def diagonal(coords)
    directions = coords.map { |x, y| (y - x).negative? ? -1 : 1 }
    x, y = coords.zip(directions).map { |range, dir| Range.new(*range).step(dir).to_a }
    x.zip(y).map { |a| a.join(',') }
  end

  def horizontal(coords)
    Range.new(*coords[1].sort).map { |i| "#{coords[0][0]},#{i}" }
  end

  def vertical(coords)
    Range.new(*coords[0].sort).map { |i| "#{i},#{coords[1][0]}" }
  end
end
