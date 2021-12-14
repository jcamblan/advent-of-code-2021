# frozen_string_literal: true

# Day 14: Extended Polymerization
class Day14
  def initialize(input = nil)
    raw = input || File.open('./14/input.txt').read
    template, pair_insertions = raw.split("\n\n")
    @pair_insertions = pair_insertions.lines(chomp: true)
                                      .map { _1.split(' -> ') }.to_h
    @template = template.chars
    @pairs = Hash.new(0)
    @letters = Hash.new(0).merge(@template.tally)
    @template.each_cons(2) do |chars|
      @pairs[chars] += 1
    end
  end

  def part1
    10.times { pair_insertions! }

    @letters.values.max - @letters.values.min
  end

  def part2
    40.times { pair_insertions! }

    @letters.values.max - @letters.values.min
  end

  def pair_insertions!
    new_hash = @pairs.dup
    @pairs.each_key do |chars|
      letter = @pair_insertions[chars.join]
      next unless letter

      new_hash[chars] -= @pairs[chars]
      new_hash[[chars[0], letter]] += @pairs[chars]
      new_hash[[letter, chars[1]]] += @pairs[chars]
      @letters[letter] += @pairs[chars]
    end

    @pairs = new_hash
  end
end
