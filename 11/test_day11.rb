# frozen_string_literal: true

require 'minitest/autorun'
# Ensure that solution for the day works with examples
class TestDay11 < Minitest::Test
  def input
    <<~INPUT
      5483143223
      2745854711
      5264556173
      6141336146
      6357385478
      4167524645
      2176841721
      6882881134
      4846848554
      5283751526
    INPUT
  end

  def setup
    @resolver = Day11.new(input)
  end

  def test_part1_result
    assert_equal 1656, @resolver.part1
  end

  def test_part2_result
    assert_equal 288_957, @resolver.part2
  end
end
