# frozen_string_literal: true

require 'minitest/autorun'
# Ensure that solution for the day works with examples
class TestDay05 < Minitest::Test
  def input
    <<~INPUT
      0,9 -> 5,9
      8,0 -> 0,8
      9,4 -> 3,4
      2,2 -> 2,1
      7,0 -> 7,4
      6,4 -> 2,0
      0,9 -> 2,9
      3,4 -> 1,4
      0,0 -> 8,8
      5,5 -> 8,2
    INPUT
  end

  def setup
    @resolver = Day05.new(input)
  end

  def test_part1_result
    assert_equal 5, @resolver.part1
  end

  def test_part2_result
    assert_equal 1924, @resolver.part2
  end
end
