# lib/workout_day.rb
class WorkoutDay
  attr_accessor :day_number, :exercises

  def initialize(day_number)
    @day_number = day_number
    @exercises = [] # exercises done in a day are stored in array
  end

  def add_exercise(exercise)
    @exercises << exercise # adds exercises to the array using <<
  end
end
