# frozen_string_literal: true

# Day 4: Giant Squid
class Day04
  def initialize(input = nil)
    @input = input || File.open('./04/input.txt').read
    @numbers = parsed_input[0][0].split(',').map(&:to_i)
    @boards = raw_boards.map { |board| Bingo::Board.new(board) }
  end

  def part1
    @numbers.each do |number|
      @boards.each do |board|
        board.process_number(number)
        return board.score if board.completed?
      end
    end
  end

  def part2; end

  private

  def parsed_input
    @parsed_input ||= @input.split("\n\n")
                            .map { |board| board.lines.map(&:chomp) }
  end

  def raw_boards
    parsed_input[1..].map do |board|
      board.map { |line| line.split(' ').map(&:to_i) }
    end
  end
end

module Bingo
  # Store and manage bingo boards informations
  class Board
    attr_reader :raw_board

    def initialize(raw_board)
      @raw_board = raw_board
      @lines = raw_board.map do |line|
        line.map { |number| { number: number, checked: false } }
      end
      @processed_numbers = []
    end

    def completed?
      @lines.any? { |line| line.all? { |cell| cell[:checked] } }
    end

    def process_number(number)
      @lines.each do |line|
        line.each do |cell|
          cell[:checked] = true if cell[:number] == number
        end
      end
      @processed_numbers << number
    end

    def score
      unchecked_numbers = @lines.flatten.filter_map do |line|
        line[:number] unless line[:checked]
      end

      unchecked_numbers.sum * @processed_numbers.last
    end
  end
end
