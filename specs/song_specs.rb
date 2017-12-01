require("minitest/autorun.rb")
require_relative("../song.rb")

class TestSong < Minitest::Test


  def setup
    @song = Song.new("One", "U2", Song::MUSIC_KIND[:POP_ROCK], 5)
  end

  def test_get_song_title
    assert_equal("One",@song.title)
  end

  def test_get_song_group
    assert_equal("U2", @song.group)
  end

  def test_get_song_music_kind
    assert_equal(Song::MUSIC_KIND[:POP_ROCK], @song.music_kind)
  end

  def test_get_song_duration
    assert_equal(5, @song.duration)
  end


end
