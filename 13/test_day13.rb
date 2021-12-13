# frozen_string_literal: true

require 'minitest/autorun'
# Ensure that solution for the day works with examples
class TestDay13 < Minitest::Test
  def input
    <<~INPUT
          6,10
      0,14
      9,10
      0,3
      10,4
      4,11
      6,0
      6,12
      4,1
      0,13
      10,12
      3,4
      3,0
      8,4
      1,10
      2,14
      8,10
      9,0

      fold along y=7
      fold along x=5
    INPUT
  end

  def setup
    @resolver = Day13.new(input)
  end

  def test_part1_result
    assert_equal 17, @resolver.part1
  end

  def test_part2_result
    assert_equal 16, @resolver.part2
  end
end
