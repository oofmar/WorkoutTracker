class Day
  attr_accessor :day_name, :exercises

  def initialize(day_name, exercises = [])
    @day_name = day_name
    @exercises = exercises.map { |ex| Exercise.new(ex[:name], ex[:weight]) }
  end

  def to_hash
    { day_name: @day_name, exercises: @exercises.map(&:to_hash) }
  end
end
