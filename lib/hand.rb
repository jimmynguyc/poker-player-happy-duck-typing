class Hand
  attr_reader :hole_cards, :community_cards

  def initialize(hole_cards, community_cards)
    @hole_cards = hole_cards
    @community_cards = community_cards
  end
end
