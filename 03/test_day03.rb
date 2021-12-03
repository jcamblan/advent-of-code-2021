# frozen_string_literal: true

require 'minitest/autorun'

# Ensure that solution for the day works with examples
class TestDay03 < Minitest::Test
  def input
    <<-INPUT
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
    INPUT
  end

  def setup
    @resolver = Day03.new(input)
  end

  def test_part1_result
    assert_equal 198, @resolver.part1
  end

  def test_part2_result
    assert_equal 900, @resolver.part2
  end
end
