class Booking

  attr_reader :room, :start_time, :duration, :end_time, :price_to_pay, :amount_paid, :guests_payment, :private_room

  def initialize(room, start_time, duration, array_of_guests_with_payment, is_private_room = false)
    @room           = room
    @start_time     = start_time
    @duration       = duration
    @end_time       = @start_time + (duration*3600)
    @guests_payment = array_of_guests_with_payment
    @price_to_pay   = @room.hourly_price * @duration
    @private_room   = is_private_room
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

  def guest_do_payment(guest, new_payment)
    return false if new_payment > payment_balance
    return false if guest.credit < new_payment
    guest_payment = @guests_payment.find{|guest_payment| guest_payment.guest == guest}
    guest_payment.do_payment(new_payment)
    return true
  end

  def get_nb_places_available()
    return @room.capacity - @guests_payment.count()
  end

  def add_new_guest_with_payment(guest_with_payment)
    return false if get_nb_places_available() == 0
    @guests_payment.push(guest_with_payment)
    return true
  end

  def room_booked_as_private?()
    return @private_room
  end

end
