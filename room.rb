class Room

  attr_reader :name, :capacity, :hourly_price, :nb_current_customer

  def initialize(name, capacity, hourly_price)
    @name           = name
    @capacity       = capacity
    @hourly_price   = hourly_price
    @nb_current_customers = 0
  end

  def nb_places_available
    return @capacity - @nb_current_customers
  end

end
