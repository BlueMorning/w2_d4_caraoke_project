require("minitest/autorun")
require_relative("../karaoke")
require_relative("../booking")
require_relative("../guest")
require_relative("../guest_payment")
require_relative("../booking")



class TestKaraoke < Minitest::Test

  def setup

    #Set the guests
    @guest1         = Guest.new("Bruce", 100)
    @guest2         = Guest.new("Ashley", 120)
    @guest3         = Guest.new("Vince", 60)

    #Set the rooms
    @room1          = Room.new("Pop",    10, 20)
    @room2          = Room.new("Rock",   5,  15)
    @room3          = Room.new("Rap",    5,  10)
    @room4          = Room.new("Reggae", 8,  5)
    @rooms          = [@room2, @room2, @room3, @room4]

    #Set the Karaoke
    @karaoke        = Karaoke.new("SingOutLoud", @rooms)

  end

  def test_get_karaoke_name
    assert_equal("SingOutLoud", @karaoke.name)
  end

  def test_book_a_private_room__available
    #First booking for this room which is available
    @guests_payment = [GuestPayment.new(@guest1,10), GuestPayment.new(@guest2), GuestPayment.new(@guest3,15)]
    is_booking_ok   = @karaoke.book_a_room(@room1, Time.new(2017,12,1,21,00,00), 2, @guests_payment, true)
    assert_equal(true, is_booking_ok)
  end

  def test_book_a_private_room__not_available
    # First booking expected to end at 23:00
    @guests_payment = [GuestPayment.new(@guest1,10), GuestPayment.new(@guest2)]
    is_booking_ok   = @karaoke.book_a_room(@room1, Time.new(2017,12,1,21,00,00), 2, @guests_payment, true)
    assert_equal(true, is_booking_ok)

    # Second booking for the same room expected to begin at 22:59 will be refused because the previous one won't be finished
    @guests_payment = [GuestPayment.new(@guest3,15)]
    is_booking_ok   = @karaoke.book_a_room(@room1, Time.new(2017,12,1,22,59,00), 2, @guests_payment, true)
    assert_equal(false, is_booking_ok)
  end

  def test_check_in_free_room
    assert_equal(true, @karaoke.check_in_free_room(@room1, [@guest1]))
  end

  def test_check_out_free_room

  end


end
