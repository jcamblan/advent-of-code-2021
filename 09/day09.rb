# frozen_string_literal: true

# Day 9: Smoke Basin
class Day09
  def initialize(input = nil)
    @input = input || File.open('./09/input.txt').read
    @matrix = @input.lines(chomp: true).map(&:chars)
  end

  def part1
    low_points.map { |coord| @matrix.dig(*coord).to_i + 1 }.sum
  end

  def low_points
    @matrix.filter_map.with_index do |row, vind|
      row.filter_map.with_index do |point, hind|
        borders = [[1, 0], [0, -1], [0, 1], [-1, 0]].filter_map do |y, x|
          ny = [vind + y, 0].max
          nx = [hind + x, 0].max
          @matrix.dig(ny, nx) unless ny == vind && nx == hind
        end
        [vind, hind] if borders.all? { _1 > point }
      end
    end.flatten(1)
  end

  def add_higher_points(vind, hind, basin_key)
    [[1, 0], [0, -1], [0, 1], [-1, 0]].filter_map do |y, x|
      ny = [vind + y, 0].max
      nx = [hind + x, 0].max
      next if ny == vind && nx == hind

      point = @matrix.dig(ny, nx)
      next if point.nil?
      next if point <= @matrix.dig(vind, hind) || point == '9'
      next if @basins.values.flatten(1).include?([ny, nx])

      @basins[basin_key] << [ny, nx]
      add_higher_points(ny, nx, basin_key)
    end
  end

  def part2
    @basins = {}
    low_points.each do |lp|
      @basins[lp] = [lp]
      add_higher_points(*lp, lp)
    end
    largest_basins = @basins.sort_by { |_, v| -v.size }[..2]
    largest_basins.map { |_, v| v.size }.inject(&:*)
  end
end
