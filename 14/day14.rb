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
    result_after(10)
  end

  def part2
    result_after(40)
  end

  private

  def result_after(times)
    times.times { @pairs = process_step }
    @letters.values.max - @letters.values.min
  end

  def process_step
    @pairs.dup.tap do |new_hash|
      @pairs.each_key do |splitted_pair|
        remove_splitted_pairs(splitted_pair, new_hash)
        add_new_pairs(splitted_pair, new_hash)
        increase_inserted_letter_count(splitted_pair)
      end
    end
  end

  def add_new_pairs(splitted_pair, hash)
    letter = inserted_letter(splitted_pair)
    hash[[splitted_pair[0], letter]] += @pairs[splitted_pair]
    hash[[letter, splitted_pair[1]]] += @pairs[splitted_pair]
  end

  def remove_splitted_pairs(splitted_pair, hash)
    hash[splitted_pair] -= @pairs[splitted_pair]
  end

  def increase_inserted_letter_count(splitted_pair)
    @letters[inserted_letter(splitted_pair)] += @pairs[splitted_pair]
  end

  def inserted_letter(splitted_pair)
    @pair_insertions[splitted_pair.join]
  end
end
