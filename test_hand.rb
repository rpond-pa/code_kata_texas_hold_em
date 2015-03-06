require 'minitest_helper'
require 'hand'

class TestHand < Minitest::Test

  def test_create_hand
    hand = "2h"
    hand = Hand.create(hand)
    assert_equal hand.size, 1
    assert_equal hand.valid?, true
    assert_equal hand.fold?, true
  end

  def test_complete_hand
    hand = "9s Ks Kd 9d 3c 6d 6h"
    hand = Hand.create(hand)
    assert_equal hand.size, 7
    assert_equal hand.valid?, true
    assert_equal hand.fold?, false
  end

  def test_invalid_hand
    assert_raises RuntimeError do
      Hand.create("yy")
    end
    invalid_hand = Hand.create("xx", false)
    assert_equal invalid_hand.valid?, false
  end

end
