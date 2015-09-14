require 'csv'

class Parser
  def self.parse(file_path)
    data = CSV.open(file_path, headers: true, header_converters: :symbol)
  end
end
