Dir['./*/*.rb'].sort.each { |f| require f }

class AdventResolver
  COMPLETED_DAYS = Dir['./*/'].sort.map { |f| Object.const_get("Day#{f.delete('/').delete('.')}") }

  def self.results
    COMPLETED_DAYS.map do |class_day|
      { class_day.to_s => class_day.new.solution}
    end
  end
end

puts AdventResolver.results