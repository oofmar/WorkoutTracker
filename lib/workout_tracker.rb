# lib/workout_tracker.rb
class WorkoutTracker
  attr_accessor :days

  def initialize
    @days = {}
  end

  def add_day(workout_day)
    @days[workout_day.day_number] = workout_day # workout day mapped to key day number
  end

  def get_day(day_number)
    @days[day_number] # gets workout day via the day number
  end
end
