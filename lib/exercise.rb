# lib/exercise.rb
class Exercise
  # attr_accessor creates getter and setter methods automatically
  attr_accessor :name, :weight

  def initialize(name, weight)
    @name = name # stores exercise name
    @weight = weight # stores exercise weight
  end
end
