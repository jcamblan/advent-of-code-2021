# frozen_string_literal: true

# Day 13: Transparent Origami
class Day13
  def initialize(input = nil)
    raw = input || File.open('./13/input.txt').read
    raw_dots, raw_folds = raw.split("\n\n").map { _1.lines(chomp: true) }
    @dots = raw_dots.map { _1.split(',').map(&:to_i) }
    @folds = raw_folds.map { _1.split(' ')[-1].split('=') }
    @paper = blank_paper
    @dots.each { fill_paper!(_1) }
  end

  def part1
    fold(@folds.first)
    @paper.flatten.count(&:positive?)
  end

  def part2
    @folds.each { fold(_1) }
    display_paper
    @paper.flatten.count(&:positive?)
  end

  private

  def display_paper
    puts ''
    puts 'REAL DAY 13 PART 2 SOLUTION :'
    @paper.each do |a|
      puts a.map { |dot| dot.positive? ? '#' : ' ' }.join
    end
    puts ''
  end

  def fold(instruction)
    case instruction[0]
    when 'y'
      @paper = vertical_fold(@paper, instruction[1].to_i)
    when 'x'
      @paper = horizontal_fold(@paper, instruction[1].to_i)
    end
  end

  def vertical_fold(paper, index)
    part1 = paper[...index]
    part2 = paper[(index + 1)..]
    part1.zip(part2.reverse).map { |a, b| a.zip(b).map(&:sum) }
  end

  def horizontal_fold(_paper, index)
    vertical_fold(@paper.transpose, index).transpose
  end

  def fill_paper!(dot)
    @paper[dot[1]][dot[0]] += 1
  end

  def blank_paper
    Array.new(paper_height) { Array.new(paper_width, 0) }
  end

  def paper_height
    @dots.map { |_x, y| y }.max + 1
  end

  def paper_width
    @dots.map { |x, _y| x }.max + 1
  end
end
