class CreateQuestionsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :question
      t.string :difficulty
      t.boolean :correct_answer
      t.integer :category_id
    end
  end
end
