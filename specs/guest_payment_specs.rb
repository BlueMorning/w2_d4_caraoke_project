require("minitest/autorun")
require_relative("../guest")
require_relative("../guest_payment")


class TestGuestPayment < Minitest::Test

  def setup
    @guest         = Guest.new("Bruce", 100)
    @guest_payment = GuestPayment.new(@guest, 0)
  end


  def test_get_guest_payment_guest
    assert_equal(@guest, @guest_payment.guest)
  end

  def test_get_guest_payment_amount_paid
    assert_equal(0, @guest_payment.amount_paid)
  end

  


end
