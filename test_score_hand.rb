require 'minitest_helper' 
require 'hand'
require 'score_hand'

class TestScoreHand < Minitest::Test

  def setup
    hand = Hand.create 'Kc 9s Ks Kd 9d 3c 6d'
    @score = ScoreHand.new(hand)
  end

  def test_two_pair
    hand = Hand.create 'Kc 9s Ks Qd 9d 3c 6d'
    assert_equal ScoreHand.new(hand).two_pair, true
  end

  def test_pair
    hand = Hand.create 'Kc 8s Ks Qd 9d 3c 6d'
    assert_equal ScoreHand.new(hand).pair, true
  end

  def test_three_of_a_kind
    hand = Hand.create 'Kc 9s Ks Kd 8d 3c 6d'
    assert_equal ScoreHand.new(hand).three_of_a_kind, true
  end
  
  def test_four_of_a_kind
    hand = Hand.create 'Kc 9s Ks Kd 8d Kh 6d'
    assert_equal ScoreHand.new(hand).four_of_a_kind, true
  end

  def test_full_house
    hand = Hand.create 'Kc 9s Ks Kd 9d 6h 6d'  # w/ two pair
    assert_equal ScoreHand.new(hand).full_house, true
    hand = Hand.create 'Kc 9s Ks Kd 9d Qh 6d'  # w/ one pair
    assert_equal ScoreHand.new(hand).full_house, true
  end

  def test_flush
    hand = Hand.create '2c 3c 4c 8c 9c 6h 6d'  # w/ pair
    assert_equal ScoreHand.new(hand).flush, true
  end

  def test_by_suite
    group = @score.by_suite
    assert_equal group["c"].size, 2
    assert_equal group["s"].size, 2
    assert_equal group["d"].size, 3
    assert_equal group["h"].size, 0
  end

  def test_by_num
    group = @score.by_num
    assert_equal group["K"].size, 3
    assert_equal group["9"].size, 2
    assert_equal group["2"].size, 0
  end

  def test_suite_to_num_map
    group = @score.suite_to_num_map
    assert_equal group["c"], [3, 13]
    assert_equal group["h"], []
  end


end
