# frozen_string_literal: true

Dir['./*/*.rb'].sort.each { |f| require f }
require 'terminal-table'
require 'minitest/autorun'
require 'pry'

# Display the results for each completed day
class AdventResolver
  COMPLETED_DAYS = Dir['./*/'].sort.map { |f| Object.const_get("Day#{f.delete('/').delete('.')}") }

  def self.all
    table(
      COMPLETED_DAYS.map.with_index(1) do |klass, index|
        [index, klass.new.part1, klass.new.part2]
      end
    )
  end

  def self.last
    klass = COMPLETED_DAYS.last
    table([[COMPLETED_DAYS.size, klass.new.part1, klass.new.part2]])
  end

  def self.day(index)
    klass = COMPLETED_DAYS[index]
    table([[index, klass.new.part1, klass.new.part2]])
  end

  def self.table(rows)
    Terminal::Table.new headings: ['Day', 'Part 1', 'Part 2'], rows: rows
  end
end

day = ARGV.find { _1.to_i.to_s == _1 && _1 != 0 }

if ARGV.include?('all')
  puts AdventResolver.all
elsif day
  puts AdventResolver.day(day.to_i)
else
  puts AdventResolver.last
end
