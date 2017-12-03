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
    @room2          = Room.new("Rock",   2,  15)
    @room3          = Room.new("Rap",    2,  10)
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
    @guests_payment = [GuestPayment.new(@guest1,70), GuestPayment.new(@guest2,0), GuestPayment.new(@guest3,50)]
    new_booking   = @karaoke.book_a_private_room(@room1, Time.new(2017,12,1,21,00,00), 2, @guests_payment)
    assert_equal(new_booking, @karaoke.bookings.last())
  end

  def test_book_a_private_room__not_available
    # First booking expected to end at 23:00
    @guests_payment = [GuestPayment.new(@guest1,20), GuestPayment.new(@guest2,60)]
    new_booking   = @karaoke.book_a_private_room(@room1, Time.new(2017,12,1,21,00,00), 2, @guests_payment)
    assert_equal(new_booking, @karaoke.bookings.last())

    # Second booking for the same room expected to begin at 22:59 will be refused because the previous one won't be finished
    @guests_payment = [GuestPayment.new(@guest3,15)]
    new_booking   = @karaoke.book_a_private_room(@room1, Time.new(2017,12,1,22,59,00), 2, @guests_payment)
    assert_nil(new_booking)
  end

  def test_is_a_free_room_available__true
    assert_equal(true, @karaoke.is_a_free_room_available(@room2, 1, [@guest1]))
    @karaoke.check_in_free_room(@room2, 1, [@guest1])

    assert_equal(true, @karaoke.is_a_free_room_available(@room2, 1, [@guest2]))
    @karaoke.check_in_free_room(@room2, 1, [@guest2])
  end

  def test_is_a_free_room_available__false

    #First part : Room2 capacity is 2
    assert_equal(true, @karaoke.is_a_free_room_available(@room2, 1, [@guest1]))
    @karaoke.check_in_free_room(@room2, 1, [@guest1])

    assert_equal(true, @karaoke.is_a_free_room_available(@room2, 1, [@guest2]))
    @karaoke.check_in_free_room(@room2, 1, [@guest2])

    #Room2 is now full, the new enquiry result is false : not available.
    assert_equal(false, @karaoke.is_a_free_room_available(@room2, 1, [@guest3]))

    #Second part : Room4 has a capacity of 8
    assert_equal(true, @karaoke.is_a_free_room_available(@room4, 1, [@guest3]))

    # The room4 has been booked as private by only 2 people
    @guests_payment = [GuestPayment.new(@guest1,20), GuestPayment.new(@guest2)]
    new_booking   = @karaoke.book_a_private_room(@room4, Time.now, 2, @guests_payment)
    assert_equal(new_booking, @karaoke.bookings.last())

    # The room4 is not full but has been declared as private so the new enquiry result is not availabe : false
    assert_equal(false, @karaoke.is_a_free_room_available(@room4, 1, [@guest3]))

  end

  def test_check_in_free_room
    nb_bookings = @karaoke.bookings.count()
    @karaoke.check_in_free_room(@room1, 1, [@guest1])
    assert_equal(nb_bookings+1, @karaoke.bookings.count())
  end

  def test_check_out_free_room
    new_booking = @karaoke.check_in_free_room(@room2, 1, [@guest1, @guest2])

    assert_equal(false, @karaoke.is_a_free_room_available(@room2, 1, [@guest3]))

    @karaoke.check_out_free_room(new_booking)

    assert_equal(true, new_booking.check_out)
    assert_equal(0,    new_booking.payment_balance)

    assert_equal(true, @karaoke.is_a_free_room_available(@room2, 1, [@guest3]))
  end

  def test_calculate_turnover_by_room
    #Room4 turnover = 20
    @guests_payment_1 = [GuestPayment.new(@guest1,20), GuestPayment.new(@guest2)]
    @karaoke.book_a_private_room(@room4, Time.new(2017,12,1,21,00,00), 2, @guests_payment_1)
    #Room4 turnover = 20 + 100
    @guests_payment_2 = [GuestPayment.new(@guest3,70), GuestPayment.new(@guest4,30)]
    @karaoke.book_a_private_room(@room4, Time.new(2017,12,1,23,01,00), 10, @guests_payment_2)

    assert_equal(120, @karaoke.get_turnover(@room4))

  end

end
