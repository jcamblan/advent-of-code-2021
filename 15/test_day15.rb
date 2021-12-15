# frozen_string_literal: true

require 'minitest/autorun'
# Ensure that solution for the day works with examples
class TestDay15 < Minitest::Test
  def input
    <<~INPUT
      1163751742
      1381373672
      2136511328
      3694931569
      7463417111
      1319128137
      1359912421
      3125421639
      1293138521
      2311944581
    INPUT
  end

  def setup
    @resolver = Day15.new(input)
  end

  def test_part1_result
    assert_equal 40, @resolver.part1
  end

  def test_part2_result
    assert_equal 315, @resolver.part2
  end
end
