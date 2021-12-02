class Day02
  def initialize
    @movements = File.readlines('./02/input.txt').map { |l| l.split(' ') }
    @horizontal_position = 0
    @depth = 0
    @aim = 0
  end

  def solution
    { '2' => result_part_2 }
  end

  def result_part_1
    instructions = @movements.dup
    instructions.group_by(&:shift)
                .map { |k,v| [k, v.flatten.map(&:to_i).sum] }.to_h

    instructions['forward'] * (instructions['down'] - instructions['up'])
  end

  def result_part_2
    @movements.each do |direction, length|
      length = length.to_i
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

    @horizontal_position * @depth
  end
end
