class UpdateGame
  @queue = :update_game

  def self.perform(game_id)
    Game.find(game_id).refresh_status!
  end
end
