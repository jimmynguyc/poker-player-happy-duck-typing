class BetRequestService
  attr_reader :game_state

  def initialize(game_state)
    @game_state = game_state
  end

  def call
    current_buy_in = game_state["current_buy_in"]
    pot = game_state["pot"]

    100
  end
end
