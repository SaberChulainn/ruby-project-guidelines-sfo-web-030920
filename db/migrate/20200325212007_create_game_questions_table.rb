class CreateGameQuestionsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :game_questions do |t|
      t.references :game
      t.references :question
      t.timestamps
    end
    
  end
end
