class BetRequestService
  attr_reader :game_state, :current_buy_in, :player,:hole_card_1, :hole_card_2

  def initialize(game_state)
    @game_state = game_state
    @current_buy_in = @game_state["current_buy_in"]

    my_index = @game_state["in_action"]
    @player = @game_state["players"][my_index]

    @hole_card_1, @hole_card_2 = @player["hole_cards"]

    puts @game_state.inspect
  end

  def call
    #current_buy_in = game_state["current_buy_in"]
    #pot = game_state["pot"]

    return raise_by(100) if bet_big?
    return call_bet if stay_in_game?

    check_or_fold
  end

  private

  # return bets
  #

  def call_bet
    current_buy_in - player["bet"]
  end

  def raise_by(n=100)
    call + n
  end

  def check_or_fold
    0
  end

  # decisions

  def bet_big?
    hole_card_same_suit? ||
      have_hole_pair? ||
      hole_cards_are_not_shitty?
  end

  def stay_in_game?
    true
  end

  # logics
  def hole_cards_are_not_shitty?
    pictures = %w{J Q K A}

    @hold_card_1["rank"].in?(pictures) || @hole_card_2["rank"].in?(picutres)
  end


  def hole_card_same_suit?
    @hole_card_1["suit"] == @hole_card_2["suit"]
  end

  def have_hole_pair?
    @hole_card_1["rank"] == @hole_card_2["rank"]
  end
end
