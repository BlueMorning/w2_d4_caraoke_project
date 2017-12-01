require("minitest/autorun")
require_relative("../play_list_management")
require_relative("../booking")
require_relative("../song")
require_relative("../guest")
require_relative("../guest_payment")
require_relative("../room")


class TestPlaylistManagement< Minitest::Test

  def setup

    @guest1   = Guest.new("Bruce", 100)
    @guest2   = Guest.new("Ashley", 120)
    @guest3   = Guest.new("Vince", 60)
    @guests_payment = [GuestPayment.new(@guest1,10), GuestPayment.new(@guest2,15), GuestPayment.new(@guest3,15)]

    @room    = Room.new("BlueRoom", 10, 20)
    @booking = Booking.new(@room, Time.new(2017,12,1,21,00,00), 2, @guests_payment)

    @song1 = Song.new("One", "U2", Song::MUSIC_KIND[:POP_ROCK], 5)
    @song2 = Song.new("Don't leave me", "PINK", Song::MUSIC_KIND[:POP], 4)
    @songs_catalog = [@song1, @song2]
    @play_list_manegement = PlayListManagement.new(@booking, @songs_catalog)


  end

  def test_add_new_song_to_play_list
    nb_songs = @play_list_manegement.play_list.count()
    @play_list_manegement.add_song_to_play_list(@song1)
    assert_equal(nb_songs+1, @play_list_manegement.play_list.count())
  end


end
