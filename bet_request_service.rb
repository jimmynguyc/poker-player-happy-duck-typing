class BetRequestService
  attr_reader :game_state, :hole_card_1, :hole_card_2

  def initialize(game_state)
    @game_state = game_state

    my_index = @game_state["in_action"]
    me = @game_state["players"][my_index]

    @hole_card_1, @hole_card_2 = me["hole_cards"]

    puts @game_state.inspect
  end

  def call
    #current_buy_in = game_state["current_buy_in"]
    #pot = game_state["pot"]

    return big_bet if bet_big?

    check_or_fold
  end

  private

  # return bets
  #
  def big_bet
    100
  end

  def check_or_fold
    0
  end

  # logics

  def bet_big?
    hole_card_same_suit? ||
      have_hole_pair?
  end

  def hole_card_same_suit?
    @hole_card_1["suit"] == @hole_card_2["suit"]
  end

  def have_hole_pair?
    @hole_card_1["rank"] == @hole_card_2["rank"]
  end
end
