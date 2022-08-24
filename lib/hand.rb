class Hand
  attr_reader :hole_cards, :community_cards

  CARD_INDEX = {
    "2" => 0,
    "3" => 1,
    "4" => 2,
    "5" => 3,
    "6" => 4,
    "7" => 5,
    "8" => 6,
    "9" => 7,
    "10" => 8,
    "J" => 9,
    "Q" => 10,
    "K" => 11,
    "A" => 12,
  }
  def initialize(hole_cards, community_cards)
    @hole_cards = hole_cards
    @community_cards = community_cards


  end

  def all_cards
    @_all_cards ||= @hole_cards + @community_cards
  end

  def pairs
    all_cards.map {|c| c["rank"] }.tally.select {|rank, count| count == 2}.sort_by {|rank, count| CARD_INDEX[rank]}.reverse
  end

  def two_pairs
    pairs.first(2)
  end

  def trips
    all_cards.map {|c| c["rank"] }.tally.select {|rank, count| count == 3}
  end

  def quads
    all_cards.map {|c| c["rank"] }.tally.select {|rank, count| count == 4}
  end

  def high_card
    #
  end
end

