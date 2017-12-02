require("minitest/autorun.rb")
require_relative("../room.rb")

class TestRoom < Minitest::Test

  def setup
    @room = Room.new("BlueRoom", 10, 20)
  end

  def test_get_room_name
    assert_equal("BlueRoom", @room.name)
  end

  def test_get_room_capacity
    assert_equal(10, @room.capacity)
  end

  def test_get_room_hourly_price
    assert_equal(20, @room.hourly_price)
  end

  def test_nb_place_available
    assert_equal(10, @room.nb_places_available)
  end

end
