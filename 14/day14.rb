# frozen_string_literal: true

# Day 14: Extended Polymerization
class Day14
  def initialize(input = nil)
    raw = input || File.open('./14/input.txt').read
    template, pair_insertions = raw.split("\n\n")
    @pair_insertions = pair_insertions.lines(chomp: true)
                                      .map { _1.split(' -> ') }.to_h
    @template = template.chars
  end

  def part1
    10.times { pair_insertions! }

    occurences = @template.uniq.map { @template.count(_1) }.sort
    occurences[-1] - occurences[0]
  end

  def part2; end

  def pair_insertions!
    new_template = []
    @template.each_cons(2).with_index(1) do |chars, _index|
      new_template << chars[0]
      letter = @pair_insertions[chars.join]
      new_template << letter if letter
    end
    new_template << @template[-1]
    @template = new_template
  end
end
