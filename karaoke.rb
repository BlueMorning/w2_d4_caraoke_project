require_relative("room")

# The guests have the choice between booking a room as private or just attend to a free room.
# For the private rooms :
# The guests have to book the room and pay up front for the duration.
# When a room is private then other guests can't access to it even if some places are still available
# For the free rooms :
# They can be book as the guests go, the guests pay when they checkout.


class Karaoke

  attr_reader :name, :bookings

  def initialize(name, rooms)
    @name     = name
    @rooms    = rooms
    @bookings = []
  end

  def book_a_private_room(room, start_time, duration, guests_payment)
    new_booking = Booking.new(room, start_time, duration, guests_payment, true)
    return nil if ! is_a_private_room_available?(room, start_time, duration, guests_payment)
    return nil if  new_booking.payment_balance != 0
    new_booking = Booking.new(room, start_time, duration, guests_payment, true)
    @bookings.push(new_booking)
    return new_booking
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

  def is_a_free_room_available(room, minimum_duration, guests)

    new_booking = Booking.new(room, Time.now, minimum_duration, guests.map{|guest| GuestPayment.new(guest, 0)})

    return false if @bookings.select{|booking|
              booking.is_private_room &&
              booking.room == new_booking.room &&
              (
                (new_booking.start_time > booking.start_time && new_booking.start_time < booking.end_time) ||
                (new_booking.end_time   > booking.start_time && new_booking.end_time   < booking.end_time)
              )
            }.count() > 0

    bookings_free_room = @bookings.select{|booking|
              ! booking.is_private_room &&
              booking.room == new_booking.room &&
              (
                (new_booking.start_time > booking.start_time && new_booking.start_time < booking.end_time) ||
                (new_booking.end_time   > booking.start_time && new_booking.end_time   < booking.end_time)
              )
            }

    nb_places_booked = 0
    bookings_free_room.each do |booking|
      nb_places_booked += booking.guests_payment.count()
    end

    return false if room.capacity < nb_places_booked + guests.count()

    return true

  end

  def check_in_free_room(room, minimum_duration, guests)
    return nil if ! is_a_free_room_available(room, minimum_duration, guests)

    new_booking = Booking.new(room, Time.now, minimum_duration, guests.map{|guest| GuestPayment.new(guest, 0)})
    @bookings.push(new_booking)

    return new_booking
  end

  def check_out_free_room(booking)
    booking.check_out_free_room()
  end

  def get_turnover(room)
    turnover_room = 0
    @bookings.select{|booking| booking.room == room }.each do |booking|
      turnover_room += booking.guests_payment_total_amount()
    end
    return turnover_room
  end

end
