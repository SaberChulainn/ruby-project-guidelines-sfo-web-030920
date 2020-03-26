require "pry"

class User < ActiveRecord::Base
  has_many :user_games
  has_many :games, through: :user_games

  @count = 0
  @correct_answer = 0
  @incorrect_answer = 0

  def set_answer
    puts "Write True or False to answer"
    answer = gets.chomp!
    if answer == "true"
      answer = TRUE
    else
      answer = FALSE
    end
  end

  def print_question(ele)
    puts "-----------------------------"
    puts "Question: #{ele[:question]}"
    puts ""
    puts "difficulty: #{ele[:difficulty]}"
  end

  def print_scores
    puts "Your current score its: #{@score}"
    puts "Number of correct answers: #{@correct_answer}"
    puts "Number of incorrect answers: #{@incorrect_answer}"
  end

  def run_questions(questions, user_game)
    i = 0
    while i < questions.length
      print_question(questions[i])
      print questions[i][:correct_answer]
      answer = set_answer
      binding.pry
      user_game.update(total_answers: user_game.total_answers + 1)
      if answer == questions[i][:correct_answer]
        user_game.update(points: user_game.points + 100, correct_answers: user_game.correct_answers + 1)
      else
        user_game.update(points: user_game.points - 100)
      end
      i += 1
    end
  end

  def start_game
    game = Game.create()
    game.initialize_game
    user_game = UserGame.create(user_id: self.id, game_id: game.id, points: 0, correct_answers: 0, total_answers: 0)
    run_questions(game.questions, user_game)
  end

  def get_points(name)
   id = User.find_by(name: name)
   return UserGame.where(user_id: id.id).sum(:points)
  end
  
end
