require("minitest/autorun")
require("date.rb")
require_relative("../booking")
require_relative("../guest")
require_relative("../guest_payment")
require_relative("../room")


class TestBooking < Minitest::Test

  def setup
    @guest1   = Guest.new("Bruce", 100)
    @guest2   = Guest.new("Ashley", 120)
    @guest3   = Guest.new("Vince", 60)
    @guests_payment = [GuestPayment.new(@guest1,10), GuestPayment.new(@guest2), GuestPayment.new(@guest3,15)]

    @room    = Room.new("BlueRoom", 5, 20)
    @booking = Booking.new(@room, Time.new(2017,12,1,21,00,00), 2, @guests_payment)
  end


  def test_get_booking_room
    assert_equal(@room, @booking.room)
  end

  def test_get_booking_start_time
    assert_equal(Time.new(2017,12,1,21,00,00), @booking.start_time)
  end

  def test_get_booking_duration
    assert_equal(2, @booking.duration)
  end

  def test_get_booking_end_time
    assert_equal(Time.new(2017,12,1,23,00,00), @booking.end_time)
  end

  def test_is_room_reserved_as_private__true
    @booking = Booking.new(@room, Time.new(2017,12,1,21,00,00), 2, @guests_payment, true)
    assert_equal(true, @booking.room_booked_as_private?())
  end

  def test_is_room_reserved_as_private__false
    assert_equal(false, @booking.room_booked_as_private?())
  end

  def test_get_booking_price_to_pay
    assert_equal(40, @booking.price_to_pay)
  end

  def test_get_booking_payment_balance
    assert_equal(15, @booking.payment_balance)
  end

  def test_get_guests_payment
    assert_equal(@guests_payment, @booking.guests_payment)
  end

  def test_get_guests_payment_total_amount
    assert_equal(25, @booking.guests_payment_total_amount)
  end

  def test_guest_do_payment
    previous_balance = @booking.payment_balance
    @booking.guest_do_payment(@guest2, 5)
    assert_equal(previous_balance-5, @booking.payment_balance)
  end

  def test_add_new_guest
    @guest4   = Guest.new("Max", 70)
    @booking.add_new_guest_with_payment(GuestPayment.new(@guest4,10))
    assert_equal(1, @booking.get_nb_places_available())
    assert_equal(35, @booking.guests_payment_total_amount())
  end

  def test_get_nb_places_available__places_available
    @guest4   = Guest.new("Max", 70)
    @guest5   = Guest.new("Harry", 70)
    @booking.add_new_guest_with_payment(GuestPayment.new(@guest4,1))
    assert_equal(1, @booking.get_nb_places_available())
    assert_equal(26, @booking.guests_payment_total_amount())
    @booking.add_new_guest_with_payment(GuestPayment.new(@guest5,3))
    assert_equal(0, @booking.get_nb_places_available())
    assert_equal(29, @booking.guests_payment_total_amount())
  end

  def test_are_places_available__no_places_available
    @guest4   = Guest.new("Max", 70)
    @guest5   = Guest.new("Harry", 70)
    @guest6   = Guest.new("Jessica", 70)

    @booking.add_new_guest_with_payment(GuestPayment.new(@guest4,1))
    assert_equal(1, @booking.get_nb_places_available())
    assert_equal(26, @booking.guests_payment_total_amount())

    @booking.add_new_guest_with_payment(GuestPayment.new(@guest5,3))
    assert_equal(0, @booking.get_nb_places_available())
    assert_equal(29, @booking.guests_payment_total_amount())

    # No place are available for any further guest, he won't be add
    @booking.add_new_guest_with_payment(GuestPayment.new(@guest6,40))
    assert_equal(0, @booking.get_nb_places_available())
    assert_equal(29, @booking.guests_payment_total_amount())
  end

  def test_check_out
    nb_places_available = @booking.get_nb_places_available()
    @booking.check_out(@guest1)
    assert_equal(nb_places_available+1, @booking.get_nb_places_available())
  end



end
