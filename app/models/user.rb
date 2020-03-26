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

  def run_questions(questions)
    i = 0
    while i < questions.length
      print_question(questions[i])
      answer = set_answer
      if answer == questions[i][:correct_answer]
        @count += 100
        @correct_answer += 1
      else
        @count -= 100
        @incorrect_answer += 1
      end
      i += 1
    end
    @count
  end

  def start_game
    game = Game.create()
    game.initialize_game
    user_game = UserGame.create(user_id: self.id, game_id: game.id)
    run_questions(game.questions)
    user_game.update(points: @count, correct_answers: @correct_answer)
  end

  def get_points(name)
   id = User.find_by(name: name)
   return UserGame.where(user_id: id.id).sum(:points)
  end
  
end
