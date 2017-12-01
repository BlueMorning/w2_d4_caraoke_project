require_relative("guest")


class GuestPayment

  attr_reader :guest, :amount_paid

  def initialize(guest, amount_paid)
    @guest       = guest
    @amount_paid = amount_paid
  end

end
