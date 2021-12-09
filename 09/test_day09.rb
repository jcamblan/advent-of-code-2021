# frozen_string_literal: true

require 'minitest/autorun'
# Ensure that solution for the day works with examples
class TestDay09 < Minitest::Test
  def input
    <<~INPUT
      2199943210
      3987894921
      9856789892
      8767896789
      9899965678
    INPUT
  end

  def setup
    @resolver = Day09.new(input)
  end

  def test_part1_result
    assert_equal 15, @resolver.part1
  end

  def test_part2_result
    assert_equal 1134, @resolver.part2
  end
end
