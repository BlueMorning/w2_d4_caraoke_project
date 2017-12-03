require("minitest/autorun")
require_relative("../play_list_management")
require_relative("../booking")
require_relative("../song")
require_relative("../guest")
require_relative("../guest_payment")
require_relative("../room")


class TestPlaylistManagement< Minitest::Test

  def setup

    @song1 = Song.new("One", "U2", Song::MUSIC_KIND[:POP_ROCK], 5)
    @song2 = Song.new("Don't leave me", "PINK", Song::MUSIC_KIND[:POP], 4)
    @song3 = Song.new("Stairway to heaven", "Led Zep", Song::MUSIC_KIND[:ROCK], 121)
    @songs_catalog = [@song1, @song2]
    @play_list_manegement = PlayListManagement.new(@songs_catalog)


  end

  def test_add_new_song_to_play_list
    nb_songs = @play_list_manegement.play_list.count()
    @play_list_manegement.add_song_to_play_list(@song1)
    assert_equal(nb_songs+1, @play_list_manegement.play_list.count())
  end

  def test_is_song_available__false
    title = "With or without you"
    assert_equal(false, @play_list_manegement.song_available?(title))
  end

  def test_is_song_available__true
    title = "One"
    assert_equal(true, @play_list_manegement.song_available?(title))
  end

  def test_control_adding_new_song__false
    nb_songs = @play_list_manegement.play_list.count()
    @play_list_manegement.control_adding_new_song(@song3)
    assert_equal(nb_songs, @play_list_manegement.play_list.count())
  end

  def test_control_adding_new_song__true
    nb_songs = @play_list_manegement.play_list.count()
    @play_list_manegement.control_adding_new_song(@song1)
    assert_equal(nb_songs+1, @play_list_manegement.play_list.count())
  end

  def test_is_favorite_song_being_played

  end

end
