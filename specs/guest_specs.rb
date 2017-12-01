require("minitest/autorun")
require_relative("../guest")

class TestGuest < Minitest::Test

  def setup
    @guest = Guest.new("Bruce", 100)
  end

  def test_get_guest_name
    assert_equal("Bruce", @guest.name)
  end

  def test_get_guest_credit
    assert_equal(100, @guest.credit)
  end

  def test_get_guest_favourite_song__nil
    assert_nil(@guest.favourite_song)
  end

end
