require("minitest/autorun.rb")
require_relative("../room.rb")
require_relative("../song.rb")
require_relative("../guest.rb")
require_relative("../play_list_management.rb")

class TestRoom < Minitest::Test

  def setup
    @room                 = Room.new("BlueRoom", 10, 20)
    @song1                = Song.new("One", "U2", Song::MUSIC_KIND[:POP_ROCK], 5)
    @song2                = Song.new("Don't leave me", "PINK", Song::MUSIC_KIND[:POP], 4)
    @song3                = Song.new("Stairway to heaven", "Led Zep", Song::MUSIC_KIND[:ROCK], 121)
    @songs_catalog        = [@song1, @song2]
    @play_list_manegement = PlayListManagement.new(@songs_catalog)
    @guest1               = Guest.new("Bruce", 100, @song1)

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

  def test_is_favorite_song_being_played
    assert_equal("So good !", @room.play_list_management.add_song_to_play_list(@guest1, @song1))
  end

end
