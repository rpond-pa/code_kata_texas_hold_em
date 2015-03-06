require 'minitest_helper' 
require 'card'

class TestCard < Minitest::Test

  def test_valid_create
    card = Card.create('Kc')
    assert_kind_of Card, card
    assert_equal card.num, 'K'
    assert_equal card.suite, 'c'
  end

  def test_valid_create_with_weird_case
    card = Card.create('kC')
    assert_kind_of Card, card
    assert_equal card.num, 'K'
    assert_equal card.suite, 'c'
  end

  def test_invalid_create
    assert_raises RuntimeError do
      Card.create('Kcc')
    end
  end

  def setup
    @card = Card.create('As')
  end

  def test_to_s
    assert_equal @card.to_s, 'As'
  end

  def test_num_to_i
    assert_equal @card.num_to_i, 14
  end

  def test_equal_cards
    card = Card.create('As')
    assert_equal card == @card, true
  end

  def test_not_equal_cards
    card = Card.create('Ac')
    assert_equal card != @card, true
  end

  def test_invalid_number
    assert_raises RuntimeError do
      Card.create('0c')
    end
  end

  def test_invalid_suite
    assert_raises RuntimeError do
      Card.create('2X')
    end
  end

end
