# frozen_string_literal: true

require 'minitest/autorun'
# Ensure that solution for the day works with examples
class TestDay14 < Minitest::Test
  def input
    <<~INPUT
      NNCB

      CH -> B
      HH -> N
      CB -> H
      NH -> C
      HB -> C
      HC -> B
      HN -> C
      NN -> C
      BH -> H
      NC -> B
      NB -> B
      BN -> B
      BB -> N
      BC -> B
      CC -> N
      CN -> C
    INPUT
  end

  def setup
    @resolver = Day14.new(input)
  end

  def test_part1_result
    assert_equal 1588, @resolver.part1
  end

  def test_part2_result
    assert_equal 16, @resolver.part2
  end
end
