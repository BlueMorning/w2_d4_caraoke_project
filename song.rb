class Song

  MUSIC_KIND = {pop_rock: "Pop/Rock", rock: "Rock", rap: "Rap", pop: "Pop", reggae: "Reggae"}

  attr_reader :title, :group

  def initialize(title, group, music_kind, duration)
    @title      = title
    @group      = group
    @music_kind = music_kind
    @duration   = duration
  end

end
