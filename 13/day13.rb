# frozen_string_literal: true

# Day 13: Transparent Origami
class Day13
  def initialize(input = nil)
    raw = input || File.open('./13/input.txt').read
    raw_dots, raw_folds = raw.split("\n\n").map { _1.lines(chomp: true) }
    @dots = raw_dots.map { _1.split(',').map(&:to_i) }
    @folds = raw_folds.map { _1.split(' ')[-1].split('=') }
  end

  def part1
    paper = blank_paper
    @dots.each { fill_paper!(paper, _1) }

    paper = fold(paper, @folds.first)
    paper.flatten.count(&:positive?)
  end

  def part2; end

  private

  def fold(paper, instruction)
    case instruction[0]
    when 'y'
      vertical_fold(paper, instruction[1].to_i)
    when 'x'
      horizontal_fold(paper, instruction[1].to_i)
    end
  end

  def vertical_fold(paper, index)
    part1 = paper[...index]
    part2 = paper[(index + 1)..]
    part1.zip(part2.reverse).map { |a, b| a.zip(b).map(&:sum) }
  end

  def horizontal_fold(paper, index)
    vertical_fold(paper.transpose, index).transpose
  end

  def fill_paper!(paper, dot)
    paper[dot[1]][dot[0]] += 1
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
