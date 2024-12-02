class Exercise
  attr_accessor :name, :weight

  def initialize(name, weight)
    @name = name
    @weight = weight
  end

  def to_hash
    { name: @name, weight: @weight }
  end
end
