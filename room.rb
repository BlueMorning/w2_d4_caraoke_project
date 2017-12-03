require_relative("play_list_management.rb")

class Room

  attr_reader :name, :capacity, :hourly_price, :play_list_management

  def initialize(name, capacity, hourly_price, songs = [])
    @name                 = name
    @capacity             = capacity
    @hourly_price         = hourly_price
    @nb_current_customers = 0
    @play_list_management = PlayListManagement.new(songs)
  end


end
