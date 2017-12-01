class Guest

  attr_reader :name, :credit, :favourite_song

  def initialize(name, credit, favourite_song = nil)
    @name           = name
    @credit         = credit
    @favourite_song = favourite_song
  end

  def decrease_credit(amount_paid)
    @credit -= amount_paid
  end




end
