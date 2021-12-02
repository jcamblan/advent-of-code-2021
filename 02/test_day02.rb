# frozen_string_literal: true

require 'minitest/autorun'

# Ensure that solution for the day works with examples
class TestDay02 < Minitest::Test
  def input
    <<-INPUT
      forward 5
      down 5
      forward 8
      up 3
      down 8
      forward 2
    INPUT
  end

  def setup
    @resolver = Day02.new(input)
  end

  def test_part1_result
    assert_equal 150, @resolver.part1
  end

  def test_part2_result
    assert_equal 900, @resolver.part2
  end
end
