require("minitest/autorun")
require("date.rb")
require_relative("../booking")
require_relative("../guest")
require_relative("../room")


class TestBooking < Minitest::Test

  def setup
    @guest1   = Guest.new("Bruce", 100)
    @guest2   = Guest.new("Ashley", 120)
    @guest3   = Guest.new("Vince", 60)
    @guests   = [@guest1, @guest2, @guest3]

    @room    = Room.new("BlueRoom", 10)
    @booking = Booking.new(@room, Time.new(2017,12,1,21,00,00), 2, @guests)
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

end
