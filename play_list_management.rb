require_relative("booking")

class PlayListManagement

  attr_reader  :play_list

  def initialize(booking, songs_catalog)
    @booking         = booking
    @songs_catalog   = songs_catalog
    @play_list       = Array.new()
  end

  def add_song_to_play_list(song)
    @play_list.push(song)
  end



end
