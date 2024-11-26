# main.rb

# requires the class files to be used in main
require_relative 'lib/exercise'
require_relative 'lib/workout_day'
require_relative 'lib/workout_tracker'

# create instances of exercises provided
bench_press = Exercise.new('Bench Press', '135 lbs')
hack_squat = Exercise.new('Hack Squat', '45 lbs')

# create instances of the workout day
day1 = WorkoutDay.new(1)
day2 = WorkoutDay.new(2)

# exercises are added to specified workout days
day1.add_exercise(bench_press)
day2.add_exercise(hack_squat)

# workout tracker instance is created
tracker = WorkoutTracker.new

# add days you worked out to the tracker
tracker.add_day(day1)
tracker.add_day(day2)

# displays the workouts that have been added
tracker.days.each do |day_number, workout_day| # day_number = key, workout_day = object of exercises
  puts "Day #{day_number} Exercises:"
  workout_day.exercises.each do |exercise|
    puts "- #{exercise.name}: #{exercise.weight}" # iterates and prints each exercise done that day one at a time
  end
  puts
end
