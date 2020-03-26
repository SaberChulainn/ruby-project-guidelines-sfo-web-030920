class Game < ActiveRecord::Base
  has_many :user_games
  has_many :users, through: :user_games
  has_many :categories
  has_many :game_questions
  has_many :questions, through: :game_questions

  def initialize_game
    Question.get_questions()
    categories = Category.all.sample(5) # Take 5 random categories
    questions = []
    i = 0
    while i < categories.length # We go through each category
      questions << Question.where(category: categories[i]).limit(3).uniq # try to get an array of questions now
      i += 1
    end
    questions.flatten.each do |q|
      GameQuestion.create(game_id: self.id, question_id: q.id)
    end 
    return self
  end
end
