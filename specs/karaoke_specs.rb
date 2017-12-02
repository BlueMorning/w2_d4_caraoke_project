require("minitest/autorun")
require_relative("../karaoke")
require_relative("../booking")
require_relative("../guest")
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


end
