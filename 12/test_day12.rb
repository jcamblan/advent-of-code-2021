# frozen_string_literal: true

require 'minitest/autorun'
# Ensure that solution for the day works with examples
class TestDay12 < Minitest::Test
  def input
    <<~INPUT
      fs-end
      he-DX
      fs-he
      start-DX
      pj-DX
      end-zg
      zg-sl
      zg-pj
      pj-he
      RW-he
      fs-DX
      pj-RW
      zg-RW
      start-pj
      he-WI
      zg-he
      pj-fs
      start-RW
    INPUT
  end

  def setup
    @resolver = Day12.new(input)
  end

  def test_part1_result
    assert_equal 226, @resolver.part1
  end

  def test_part2_result
    assert_equal 3509, @resolver.part2
  end
end
