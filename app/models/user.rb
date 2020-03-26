require "pry"

class User < ActiveRecord::Base
  has_many :user_games
  has_many :games, through: :user_games

  def set_answer
    puts "Write True or False to answer or type exit to quit your current game!"
    answer = gets.chomp!
    if answer.downcase == "true"
      answer = TRUE
    elsif answer == "exit"
      puts "Thank you for playing!"
      answer = "exit"
    else
      answer = FALSE
    end
  end

  def print_question(ele)
    puts "-----------------------------"
    puts "difficulty: #{ele[:difficulty]}\n\n"
    puts "Question: #{ele[:question]}"
  end

  def print_scores(user_game)
    puts "Your current score is: #{user_game.points}"
    puts "Number of correct answers: #{user_game.correct_answers}"
    puts "Number of incorrect answers: #{user_game.total_answers - user_game.correct_answers}"
    puts "Number of total questions:#{user_game.total_answers}"
  end

  def run_questions(questions, user_game)
    i = 0
    while i < questions.length
      print_question(questions[i])
      answer = set_answer
      user_game.update(total_answers: user_game.total_answers + 1)
      if answer == questions[i][:correct_answer]
        user_game.update(points: user_game.points + 100, correct_answers: user_game.correct_answers + 1)
      elsif answer == "exit"
        return
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
    print_scores(user_game)
  end

  def get_points(name)
   id = User.find_by(name: name)
   return UserGame.where(user_id: id.id).sum(:points)
  end
  
end
