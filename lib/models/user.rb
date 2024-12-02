class User
    attr_accessor :name, :split_days
  
    def initialize(name = "", split_days = [])
      @name = name
      @split_days = split_days.map { |day| Day.new(day[:day_name], day[:exercises]) }
    end
  
    def to_hash
      { name: @name, split_days: @split_days.map(&:to_hash) }
    end
  end
  