require 'card'

class Hand

  attr_accessor :cards

  def initialize(cards = [])
    @cards = cards
  end

  def self.create(string, validate=true)
    cards = string.split(" ").map { |s| Card.create(s, validate) }
    new(cards).tap do |hand|
      raise "Invalid hand" if validate && !hand.valid?
    end
  end

  def valid?
    valid_hand_size = (1..7).include?(cards.size)
    valid_cards = cards.all? { |card| card.valid? }
    valid_hand_size && valid_cards
  end

  def fold?
    size != 7
  end

  def size
    cards.size
  end

end

