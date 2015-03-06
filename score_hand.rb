
class ScoreHand

  attr_accessor :hand

  def initialize(hand)
    @hand = hand
  end
  
  # high card
  # 1 pair
  # 2 pair
  # 3 of a kind
  # straight
  # flush
  # full house
  # four of a kind
  # straight flush
  # royal flush
  
  def flush
    by_suite.any? { |suite, cards| cards.size == 5 }
  end
  
  def full_house
    three_of_a_kind && pair || three_of_a_kind && two_pair
  end

  def four_of_a_kind
    of_a_kind(4).count == 1
  end
  
  def pair
    of_a_kind(2).count == 1
  end
  
  def two_pair
    of_a_kind(2).count == 2
  end

  def three_of_a_kind
    count = of_a_kind(3).count
    count == 1 or count == 2
  end

  def of_a_kind(x)
    by_num.select { |suite, list| list.count == x }
  end
  
  # => {"c"=>[3, 13], "s"=>[9, 13], "d"=>[6, 9, 13]}
  def suite_to_num_map
    @suite_to_num_map ||= begin
      default_hash = Hash.new() { |h,k| h[k]= [] }
      group = by_suite.inject({}) do |result, (suite, list)|
        result[suite] = list.map { |card| card.num_to_i }.sort
        result
      end
      default_hash.merge(group)
    end
  end
  
  # => {"c"=>[Kc, 3c], "s"=>[9s, Ks], "d"=>[Kd, 9d, 6d]}
  def by_suite
    @by_suite ||= begin
      default_hash = Hash.new() { |h,k| h[k]= [] }
      group = hand.cards.group_by { |card| card.suite }
      default_hash.merge(group)
    end
  end
  
  # => "K"=>[Kc, Ks, Kd], "9"=>[9s, 9d], "3"=>[3c], "6"=>[6d]}
  def by_num
    @by_num ||= begin
      default_hash = Hash.new() { |h,k| h[k]= [] }
      group = hand.cards.group_by { |card| card.num }
      default_hash.merge(group)
    end
  end

end
