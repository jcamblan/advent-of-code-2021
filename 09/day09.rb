# frozen_string_literal: true

# Day 9: Smoke Basin
class Day09
  def initialize(input = nil)
    @input = input || File.open('./09/input.txt').read
    @matrix = @input.lines(chomp: true).map(&:chars)
  end

  def part1
    @matrix.filter_map.with_index do |row, vind|
      row.filter_map.with_index do |point, hind|
        borders = [[1, 0], [0, -1], [0, 1], [-1, 0]].filter_map do |y, x|
          ny = [vind + y, 0].max
          nx = [hind + x, 0].max
          @matrix.dig(ny, nx) unless ny == vind && nx == hind
        end
        point.to_i + 1 if borders.all? { _1 > point }
      end
    end.flatten.sum
  end

  def part2; end
end
