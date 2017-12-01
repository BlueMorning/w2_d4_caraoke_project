class Booking

  attr_reader :room, :start_time, :duration, :end_time, :price_to_pay, :amount_paid

  def initialize(room, start_time, duration, array_of_guests)
    @room         = room
    @start_time   = start_time
    @duration     = duration
    @end_time     = @start_time + (duration*3600)
    @guests       = array_of_guests
    @price_to_pay = @room.hourly_price * @duration
    @amount_paid  = 0
  end

  def price_to_pay
    return @price_to_pay
  end

  def amount_paid
    return @amount_paid
  end

end
