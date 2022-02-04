class UsaDates
  attr_reader :name, :date

  def initialize(data)
    if data.class == Array
      @name = data[1]
      @date = data[1]
    else
      @name = data[:localName]
      @date = data[:date]
    end
  end
end
