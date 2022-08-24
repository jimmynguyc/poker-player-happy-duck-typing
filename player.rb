require_relative 'bet_request_service'
require_relative 'lib/hand'

class Player

  VERSION = "Negreanu Bot v1.0"

  def bet_request(game_state)
    BetRequestService.new(game_state).call
  end

  def showdown(game_state)

  end
end
