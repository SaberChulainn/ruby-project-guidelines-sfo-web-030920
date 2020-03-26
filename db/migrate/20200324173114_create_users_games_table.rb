class CreateUsersGamesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :user_games do |t|
      t.integer :user_id
      t.integer :game_id
      t.integer :points, default: 0
      t.integer :correct_answers, default: 0
      t.integer :total_answers, default: 0
      t.timestamps
    end
  end
end
