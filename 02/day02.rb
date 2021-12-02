class Day02
  def initialize
    @instructions = File.readlines('./02/input.txt')
                        .map { |l| l.split(' ') }
                        .group_by(&:shift)
                        .map { |k,v| [k, v.flatten.map(&:to_i).sum] }.to_h
    @horizontal_position = @instructions['forward']
    @depth = @instructions['down'] - @instructions['up']
  end

  def solution
   { '1' => @horizontal_position * @depth }
  end
end