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
    binding.pry
    questions.flatten.each do |q|
      GameQuestion.create(game_id: self.id, question_id: q.id)
    end
    return self
  end

end

#We want it to basically have rows and colums
#Get all category id's and sample them for which categories we will be giving
#           Welcome to Jeopardy
#   Category1     Category2      Category3
#     Q$100         Q$100          Q$100
#     Q$500         Q$500          Q$500
#     Q$1000        Q$1000         Q$1000
#
# Basically in this diagram it will be 4 rows, 3 colums.
# We don't use row 0 because that will be where the categories are stored
#question[1][1], question[1][2], question[1][3]
#question[2][1], question[2][2], question[2][3]
#question[3][1], question[3][2], question[3][3]
#
