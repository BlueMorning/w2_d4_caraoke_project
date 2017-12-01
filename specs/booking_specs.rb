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

    @room    = Room.new("BlueRoom", 10, 20)
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

  def test_get_booking_price_to_pay
    assert_equal(40, @booking.price_to_pay)
  end

  def test_get_booking_amount_paid
    assert_equal(0, @booking.amount_paid)
  end

  def test_get_booking_payment_balance
    assert_equal(40, @booking.payment_balance)
  end

  def test_get_guests_payment
    assert_equal(@guests_payment, @booking.guests_payment)
  end

  def test_get_guests_payment_total_amount
    assert_equal(25, @booking.guests_payment_total_amount)
  end

end
