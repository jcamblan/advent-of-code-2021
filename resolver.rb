# frozen_string_literal: true

Dir['./*/*.rb'].sort.each { |f| require f }
require 'terminal-table'
require 'minitest/autorun'
require 'pry'

# Display the results for each completed day
class AdventResolver
  COMPLETED_DAYS = Dir['./*/'].sort.map { |f| Object.const_get("Day#{f.delete('/').delete('.')}") }

  def self.results
    rows = COMPLETED_DAYS.map.with_index(1) do |klass, index|
      [index, klass.new.part1, klass.new.part2]
    end

    Terminal::Table.new headings: ['Day', 'Part 1', 'Part 2'], rows: rows
  end
end

puts AdventResolver.results
