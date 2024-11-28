require 'json'

module StorageHelper
  DATA_FILE = './data/user_data.json'

  # Loads data from the JSON file
  def self.load_data
    if File.exist?(DATA_FILE)
      JSON.parse(File.read(DATA_FILE), symbolize_names: true)
    else
      create_default_data
    end
  end

  # Saves data to the JSON file
  def self.save_data(data)
    File.write(DATA_FILE, JSON.pretty_generate(data))
  end

  # Default data template
  def self.create_default_data
    default_data = {
      name: "",
      split_days: []
    }
    save_data(default_data)
    default_data
  end
end
