class Guest

  attr_reader :name, :credit, :favourite_song

  def initialize(name, credit, favourite_song = nil)
    @name           = name
    @credit         = credit
    @favourite_song = favourite_song
  end






end
