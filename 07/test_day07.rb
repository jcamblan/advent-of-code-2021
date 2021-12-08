# frozen_string_literal: true

require 'minitest/autorun'
# Ensure that solution for the day works with examples
class TestDay07 < Minitest::Test
  def input
    <<~INPUT
      16,1,2,0,4,2,7,1,2,14
    INPUT
  end

  def setup
    @resolver = Day07.new(input)
  end

  def test_part1_result
    assert_equal 37, @resolver.part1
  end

  def test_part2_result
    assert_equal 168, @resolver.part2
  end
end
