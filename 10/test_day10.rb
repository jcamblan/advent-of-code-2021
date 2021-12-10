# frozen_string_literal: true

require 'minitest/autorun'
# Ensure that solution for the day works with examples
class TestDay10 < Minitest::Test
  def input
    <<~INPUT
      [({(<(())[]>[[{[]{<()<>>
      [(()[<>])]({[<{<<[]>>(
      {([(<{}[<>[]}>{[]{[(<()>
      (((({<>}<{<{<>}{[]{[]{}
      [[<[([]))<([[{}[[()]]]
      [{[{({}]{}}([{[{{{}}([]
      {<[[]]>}<{[{[{[]{()[[[]
      [<(<(<(<{}))><([]([]()
      <{([([[(<>()){}]>(<<{{
      <{([{{}}[<[[[<>{}]]]>[]]
    INPUT
  end

  def setup
    @resolver = Day10.new(input)
  end

  def test_part1_result
    assert_equal 26_397, @resolver.part1
  end

  def test_part2_result
    assert_equal 288_957, @resolver.part2
  end
end
