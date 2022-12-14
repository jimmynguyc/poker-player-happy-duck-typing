class BetRequestService
  attr_reader :game_state,
    :current_buy_in,
    :player,
    :hole_card_1,
    :hole_card_2,
    :community_cards,
    :round,
    :hand

  def initialize(game_state)
    @game_state = game_state
    @current_buy_in = @game_state["current_buy_in"]
    @community_cards = @game_state["community_cards"]

    my_index = @game_state["in_action"]
    @player = @game_state["players"][my_index]

    @hole_card_1, @hole_card_2 = @player["hole_cards"]

    @round = {
      0 => :pre_flop,
      3 => :flop,
      4 => :turn,
      5 => :river
    }[@community_cards.count]

    @hand = Hand.new(@player["hole_cards"], @game_state["community_cards"])

    puts @game_state.inspect
  end

  def call
    return raise_by(50) if have_nuts? && hole_card_part_of_nuts?
    return raise_by(100) if bet_big?
    return check_or_fold if hole_cards_are_shitty?

      call_bet # stay in game
  end

  private

  # return bets

  def call_bet
    current_buy_in - player["bet"]
  end

  def raise_by(n=100)
    (call_bet + n).to_i
  end

  def check_or_fold
    0
  end

  # decisions

  def bet_big?
    (hole_card_same_suit? ||
      have_hole_pair?) &&
      hole_cards_are_not_shitty?
  end

  def have_nuts?
    pictures = %w{J Q K A}
    (!hand.pairs.empty? && pictures.include?(hand.pairs.first.first)) || !hand.trips.empty? || !hand.quads.empty?
  end

  def hole_card_part_of_nuts?
    if (pair = hand.pairs) && !pair.empty?
      return true if [@hole_card_1["rank"], @hole_card_2["rank"]].include?(pair.first.first)
    end

    if (trips = hand.trips) && !trips.empty?
      return true if [@hole_card_1["rank"], @hole_card_2["rank"]].include?(trips.keys.first)
    end

    if (quads = hand.quads) && !quads.empty?
      return true if [@hole_card_1["rank"], @hole_card_2["rank"]].include?(quads.keys.first)
    end

    false
  end

  # logics

  def hole_cards_are_shitty?
    shitty_ranks = %w{2 3 4 5 6}

    shitty_ranks.include?(@hole_card_1["rank"]) && shitty_ranks.include?(@hole_card_2["rank"])
  end

  def hole_cards_are_not_shitty?
    pictures = %w{J Q K A}

    pictures.include?(@hole_card_1["rank"]) || pictures.include?(@hole_card_2["rank"])
  end


  def hole_card_same_suit?
    @hole_card_1["suit"] == @hole_card_2["suit"]
  end

  def have_hole_pair?
    @hole_card_1["rank"] == @hole_card_2["rank"]
  end

  # hands

  def have_pairs?
    [@hole_card_1["rank"], @hole_card_2["rank"]] + @game_state["community_cards"].map {|c| c["rank"]}
  end
end
