User.destroy_all
Game.destroy_all
UserGame.destroy_all

puts "User, Game, UserGame tables were deleted"

5.times do |x|
  us = User.create(name: "#{"Eduardo"}-#{x}")
  ga = Game.create()
  UserGame.create(user_id: us.id, game_id: ga.id)
end
