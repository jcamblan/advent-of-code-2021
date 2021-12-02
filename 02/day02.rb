# frozen_string_literal: true

# Day 2: Dive!
class Day02
  def initialize(input = nil)
    input ||= File.open('./02/input.txt').read
    @movements = input.lines.map do |l|
      direction, length = l.split(' ')
      [direction, length.to_i]
    end
    @horizontal_position = 0
    @depth = 0
    @aim = 0
  end

  def part1
    instructions = @movements.dup
    instructions = instructions.group_by(&:shift)
                               .transform_values { |v| v.flatten.sum }

    instructions['forward'] * (instructions['down'] - instructions['up'])
  end

  def part2
    @movements.each do |direction, length|
      move_submarine(direction, length)
    end

    @horizontal_position * @depth
  end

  private

  def move_submarine(direction, length)
    case direction
    when 'forward'
      @horizontal_position += length
      @depth += @aim * length
    when 'down'
      @aim += length
    when 'up'
      @aim -= length
    end
  end
end
