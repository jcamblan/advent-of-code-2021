# frozen_string_literal: true

# Day 4: Giant Squid
class Day04
  def initialize(input = nil)
    @input = input || File.open('./04/input.txt').read
    @numbers = parsed_input[0][0].split(',').map(&:to_i)
    @boards = raw_boards.map { |board| Bingo::Board.new(board) }
    complete_boards!
  end

  def part1
    @boards.min_by { |board| board.processed_numbers.count }.score
  end

  def part2
    @boards.max_by { |board| board.processed_numbers.count }.score
  end

  private

  def complete_boards!
    @numbers.each do |number|
      @boards.each do |board|
        next if board.completed?

        board.process_number(number)
      end
    end
  end

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
    attr_reader :processed_numbers

    def initialize(raw_board)
      @raw_board = raw_board
      @lines = raw_board.map do |line|
        line.map { |number| { number: number, checked: false } }
      end
      @processed_numbers = []
    end

    def completed?
      columns = @lines.dup

      by_line = @lines.any? { |line| line.all? { |cell| cell[:checked] } }
      by_column = columns.transpose.any? { |line| line.all? { |cell| cell[:checked] } }

      by_line || by_column
    end

    def process_number(number)
      @processed_numbers << number

      @lines.each do |line|
        line.each do |cell|
          cell[:checked] = true if cell[:number] == number
        end
      end
    end

    def score
      unchecked_numbers = @lines.flatten.filter_map do |line|
        line[:number] unless line[:checked]
      end

      unchecked_numbers.sum * @processed_numbers.last
    end
  end
end
