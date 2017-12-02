require_relative("room")


class Karaoke

  attr_reader :name

  def initialize(name, rooms)
    @name   = name
    @rooms  = rooms
  end


end
