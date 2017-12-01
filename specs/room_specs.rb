require("minitest/autorun.rb")
require_relative("../room.rb")

class TestRoom < Minitest::Test

  def setup
    @room = Room.new("BlueRoom", 10)
  end

  def test_get_room_name
    assert_equal("BlueRoom", @room.name)
  end

  def test_get_room_capacity
    assert_equal(10, @room.capacity)
  end

end
