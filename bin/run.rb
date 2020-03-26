require_relative '../config/environment'


puts "Welcome to Jeopardy!"
flag = true
startmessage = false
name = 0

def new_user(name)
    return User.find_or_create_by(name: name)
  end

  #Handles the game
while flag != false

    if startmessage == false
        puts "Please enter your username, or simply type 'exit'!"
    end
    answer = gets.chomp!
    if answer.downcase == "exit"
        flag = false
    elsif startmessage == false
        name = answer
        user = new_user(answer)
        startmessage = true
        puts default_message = "Thank you #{name}! \n\nYou have these commands \n\nstart_game, show_points, exit"
    elsif answer.downcase == "show_points"
        user.get_points(name)
    elsif answer.downcase == "start_game"
        puts "add game method here"
    else
        puts default_message
    end

end


