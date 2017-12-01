require("minitest/autorun.rb")
require_relative("../song.rb")

class TestSong < Minitest::Test


  def setup
    @song = Song.new("One", "U2", Song::MUSIC_KIND[:POP_ROCK], 5)
  end

  def test_get_song_title
    assert_equal("One",@song.title)
  end


end
