class Card

  SUITES=%w(d h s c)
  NUMBERS=%(2 3 4 5 6 7 8 9 T J Q K A)
  NUMBERS_TO_I={ 'T' => 10, 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14 }

  attr_accessor :num, :suite

  def initialize(num, suite)
    @num = num
    @suite = suite
  end

  def self.create(string, validate = true)
    raise "Invalid format for #{string}" unless string.size == 2
    new(string[0].upcase, string[1].downcase).tap do |card|
      raise "invalid card" if validate && !card.valid?
    end
  end

  def valid?
    valid_number = NUMBERS.include?(num)
    valid_suite = SUITES.include?(suite)
    valid_number && valid_suite
  end

  def to_s
    num + suite
  end

  def num_to_i
    if @num =~ /\d/
      @num.to_i
    else
      NUMBERS_TO_I[@num.upcase]
    end
  end

  def ==(card)
    @num == card.num && @suite == card.suite
  end

end



