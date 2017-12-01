require_relative("guest")


class GuestPayment

  attr_reader :guest, :amount_paid

  def initialize(guest, amount_paid = 0)
    @guest       = guest
    @amount_paid = amount_paid
  end

  def do_payment(new_payment)
    @amount_paid += new_payment
    guest.decrease_credit(new_payment)
  end

end
