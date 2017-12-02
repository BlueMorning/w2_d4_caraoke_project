require_relative("room")


class Karaoke

  attr_reader :name

  def initialize(name, rooms)
    @name     = name
    @rooms    = rooms
    @bookings = []
  end

  def book_a_room(room, start_time, duration, guests_payment, is_private)
    return false if ! is_a_private_room_available?(room, start_time, duration, guests_payment)
    booking = Booking.new(room, start_time, duration, guests_payment, is_private)
    @bookings.push(booking)
    return true
  end

  def is_a_private_room_available?(room, start_time, duration, guests_payment)

    new_booking = Booking.new(room, start_time, duration, guests_payment)

    return false if @bookings.select{|booking|
              booking.room == new_booking.room && booking.end_time > new_booking.start_time &&
              booking.end_time < new_booking.end_time}.count() > 0

    return false if @bookings.select{|booking|
              booking.room == new_booking.room && booking.start_time > new_booking.start_time &&
              booking.start_time < new_booking.end_time}.count() > 0

    return false if room.capacity < guests_payment.count()

    return true

  end

  def is_a_free_room_available?(room, minimum_duration, guests)

    new_booking = Booking.new(room, Time.now, minimum_duration, guests.map{|guest| GuestPayment.new(guest, 0)})

    return false if @bookings.select{|booking|
              booking.room == new_booking.room && booking.end_time > new_booking.start_time &&
              booking.end_time < new_booking.end_time}.count() > 0

    return false if @bookings.select{|booking|
              booking.room == new_booking.room && booking.start_time > new_booking.start_time &&
              booking.start_time < new_booking.end_time}.count() > 0

    return false if room.nb_places_available < guests.count()

    return true

  end

  def check_in_free_room(room, guests)

  end

  def check_in_free_room(room, guests)

  end


end
