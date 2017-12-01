class Booking

  attr_reader :room, :start_time, :duration, :end_time

  def initialize(room, start_time, duration, array_of_guests)
    @room         = room
    @start_time   = start_time
    @duration     = duration
    @end_time     = @start_time + (duration*3600)
    @guests       = array_of_guests
  end


end
