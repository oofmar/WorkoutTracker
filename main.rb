# Load necessary files
puts "Loading necessary files..."
require_relative './lib/helpers/storage_helper'
require_relative './lib/models/user'
require_relative './lib/models/workout_day'
require_relative './lib/models/exercise'

puts "Files loaded successfully!"

# Helper method to display the user's workout split
def display_split(data)
  puts "\nYour Current Workout Split:"
  if data[:split_days].empty?
    puts "No workout days found."
  else
    data[:split_days].each_with_index do |day, index|
      puts "#{index + 1}. #{day[:day_name]}"
      day[:exercises].each_with_index do |exercise, ex_index|
        puts "   #{ex_index + 1}. #{exercise[:name]} - #{exercise[:weight]} lbs"
      end
    end
  end
end

# Helper method to edit a workout day
def edit_day(data)
  display_split(data)

  # if the user does not have any days added do not allow them to edit anything
  if data[:split_days].empty?
    return
  end

  puts "\nSelect a day to edit (number) or type 'exit' to cancel:"
  input = gets.chomp
  return if input.downcase == "exit"

  day_index = input.to_i - 1
  if day_index < 0 || day_index >= data[:split_days].length
    puts "Invalid selection. Returning to menu."
    return
  end

  day = data[:split_days][day_index]
  puts "Editing #{day[:day_name]}"
  puts "1. Rename Day"
  puts "2. Edit Exercises"
  puts "3. Delete Day"
  choice = gets.chomp.to_i

  case choice
  when 1
    puts "Enter new name for the day:"
    new_name = gets.chomp
    day[:day_name] = new_name
    puts "Day renamed to '#{new_name}'."
  when 2
    edit_exercises(day)
  when 3
    data[:split_days].delete_at(day_index)
    puts "Day '#{day[:day_name]}' deleted."
  else
    puts "Invalid choice."
  end

  StorageHelper.save_data(data)
end

# Helper method to edit exercises within a day
def edit_exercises(day)
  puts "\nEditing Exercises in #{day[:day_name]}"
  day[:exercises].each_with_index do |exercise, index|
    puts "#{index + 1}. #{exercise[:name]} - #{exercise[:weight]} lbs"
  end
  puts "1. Add Exercise"
  puts "2. Edit Existing Exercise"
  puts "3. Delete Exercise"
  choice = gets.chomp.to_i

  case choice
  when 1
    puts "Enter exercise name:"
    name = gets.chomp
    puts "Enter weight:"
    weight = gets.chomp.to_i
    day[:exercises] << { name: name, weight: weight }
    puts "Exercise '#{name}' added with #{weight} lbs."
  when 2
    puts "Select an exercise to edit (number):"
    ex_index = gets.chomp.to_i - 1
    if ex_index < 0 || ex_index >= day[:exercises].length
      puts "Invalid selection."
      return
    end
    puts "Editing #{day[:exercises][ex_index][:name]}"
    puts "Enter new name (leave blank to keep current):"
    new_name = gets.chomp
    puts "Enter new weight (leave blank to keep current):"
    new_weight = gets.chomp
    day[:exercises][ex_index][:name] = new_name unless new_name.empty?
    day[:exercises][ex_index][:weight] = new_weight.to_i unless new_weight.empty?
    puts "Exercise updated."
  when 3
    puts "Select an exercise to delete (number):"
    ex_index = gets.chomp.to_i - 1
    if ex_index < 0 || ex_index >= day[:exercises].length
      puts "Invalid selection."
      return
    end
    deleted_exercise = day[:exercises].delete_at(ex_index)
    puts "Deleted exercise '#{deleted_exercise[:name]}'."
  else
    puts "Invalid choice."
  end
end

# Ensure user name is set
def ensure_user_name(data)
  if data[:name].nil? || data[:name].strip.empty?
    puts "No user data found! Let's set up your workout tracker."
    puts "Enter your name:"
    user_name = gets.chomp.strip
    until !user_name.empty?
      puts "Name cannot be empty. Please enter your name:"
      user_name = gets.chomp.strip
    end
    data[:name] = user_name
    StorageHelper.save_data(data)
    puts "Profile created successfully for #{user_name}!"
  else
    puts "Welcome back, #{data[:name]}!"
  end
end

# Main entry point
def main
  puts "Welcome to the Workout Tracker!"

  # Load data from the file
  data = StorageHelper.load_data

  ensure_user_name(data)

  loop do
    puts "\nMain Menu:"
    puts "1. View Workout Split"
    puts "2. Add Workout Day"
    puts "3. Edit Workout Day"
    puts "4. Exit"
    input = gets.chomp.to_i

    case input
    when 1
      display_split(data)
    when 2
      puts "Enter name for the new workout day:"
      day_name = gets.chomp
      data[:split_days] << { day_name: day_name, exercises: [] }
      puts "Added new workout day: '#{day_name}'."
      StorageHelper.save_data(data)
    when 3
      edit_day(data)
    when 4
      puts "Exiting Workout Tracker. Goodbye!"
      break
    else
      puts "Invalid choice. Please try again."
    end
  end
end

# Run the program
begin
  main
rescue => e
  puts "An error occurred: #{e.message}"
  puts e.backtrace
end
