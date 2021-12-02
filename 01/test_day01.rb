# frozen_string_literal: true

require 'minitest/autorun'

# Ensure that solution for the day works with examples
class TestDay01 < Minitest::Test
  def input
    <<-INPUT
      199
      200
      208
      210
      200
      207
      240
      269
      260
      263
    INPUT
  end

  def setup
    @resolver = Day01.new(input)
  end

  def test_part1_result
    assert_equal 7, @resolver.part1
  end

  def test_part2_result
    assert_equal 5, @resolver.part2
  end
end
