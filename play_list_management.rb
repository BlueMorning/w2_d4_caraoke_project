require_relative("booking")

class PlayListManagement

  attr_reader  :play_list

  def initialize(songs_catalog)
    @songs_catalog   = songs_catalog
    @play_list       = Array.new()
  end

  def add_song_to_play_list(guest, song)
    @play_list.push(song)
    return "So good !" if guest.favourite_song == song
  end

  def song_available?(title)
    return @songs_catalog.find{|song| song.title == title} != nil
  end

  def control_adding_new_song(guest, song)
    return false if ! song_available?(song.title)
    add_song_to_play_list(guest, song)
    return true
  end

end
