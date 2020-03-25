require 'pry'
class User < ActiveRecord::Base
  has_many :user_games
  has_many :games, through: :user_games


  def start_game
    game = Game.create()
    game.initialize_game
    user_game = UserGame.create(user_id: self.id, game_id: game.id)
    
    binding.pry
    puts "hello"
  end

end
