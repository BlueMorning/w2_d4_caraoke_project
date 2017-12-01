class Room

  attr_reader :name, :capacity, :hourly_price

  def initialize(name, capacity, hourly_price)
    @name           = name
    @capacity       = capacity
    @hourly_price   = hourly_price
  end


end
