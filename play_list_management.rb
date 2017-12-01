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

  def song_available?(title)
    return @songs_catalog.find{|song| song.title == title} != nil
  end

  def is_enough_time_left?(song_duration)
    return song_duration <= (@booking.end_time - Time.now())/60
  end

  def control_adding_new_song(song)
    return false if ! song_available?(song.title)
    return false if ! is_enough_time_left?(song.duration)
    add_song_to_play_list(song)
    return true
  end

end
