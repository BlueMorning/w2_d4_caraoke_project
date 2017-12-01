class Song

  MUSIC_KIND = {pop_rock: "Pop/Rock", rock: "Rock", rap: "Rap", pop: "Pop", reggae: "Reggae"}

  attr_reader :title

  def initialize(title, author, music_kind, duration)
    @title      = title
    @author     = author
    @music_kind = music_kind
    @duration   = duration
  end

end
