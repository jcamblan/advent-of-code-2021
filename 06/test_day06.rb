# frozen_string_literal: true

require 'minitest/autorun'
# Ensure that solution for the day works with examples
class TestDay06 < Minitest::Test
  def input
    <<~INPUT
      3,4,3,1,2
    INPUT
  end

  def setup
    @resolver = Day06.new(input)
  end

  def test_part1_result
    assert_equal 5934, @resolver.part1
  end

  def test_part2_result
    assert_equal 26_984_457_539, @resolver.part2
  end
end
