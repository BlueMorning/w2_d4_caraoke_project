class Booking

  attr_reader :room

  def initialize(room, date, duration, array_of_guests)
    @room      = room
    @date      = date
    @duration  = duration
    @guests    = array_of_guests
  end


end
