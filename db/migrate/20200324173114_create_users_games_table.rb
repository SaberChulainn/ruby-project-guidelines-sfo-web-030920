class CreateUsersGamesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :user_games do |t|
      t.integer :user_id
      t.integer :game_id
      t.integer :points
      t.integer :correct_answers
      t.integer :total_answers
      t.timestamps
    end
  end
end
