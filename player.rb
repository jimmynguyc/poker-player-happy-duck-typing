require_relative 'bet_request_service'

class Player

  VERSION = "Negreanu Bot"

  def bet_request(game_state)
    BetRequestService.new(game_state).call
  end

  def showdown(game_state)

  end
end
