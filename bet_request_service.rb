class BetRequestService
  attr_reader :game_state

  def initialize(game_state)
    @game_state = game_state
    puts @game_state.inspect
  end

  def call
    current_buy_in = game_state["current_buy_in"]
    pot = game_state["pot"]
    my_index = game_state["in_action"]


    100
  end
end
