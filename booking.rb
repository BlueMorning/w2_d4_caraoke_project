class Booking

  attr_reader :room, :start_time, :duration, :end_time, :price_to_pay, :amount_paid, :guests_payment

  def initialize(room, start_time, duration, array_of_guests_payment)
    @room           = room
    @start_time     = start_time
    @duration       = duration
    @end_time       = @start_time + (duration*3600)
    @guests_payment = array_of_guests_payment
    @price_to_pay   = @room.hourly_price * @duration
    @amount_paid    = 0
  end

  def price_to_pay
    return @price_to_pay
  end

  def payment_balance
    return @price_to_pay - guests_payment_total_amount()
  end

  def guests_payment_total_amount
    return @guests_payment.map{|guest_payment| guest_payment.amount_paid}.reduce{|total, amount_paid| total+amount_paid}
  end

end
