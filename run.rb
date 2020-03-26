require_relative './config/environment'


puts "Welcome to Jeopardy!"
flag = true
startmessage = false
name = 0

def new_user(name)
    return User.find_or_create_by(name: name)
  end

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
    puts "Thank you #{name}! \n\nYou have these commands \n\nstart_game, show_points, exit"
end

while flag != false
    default = "\n\nWhat else would you like to do? You have these commands \n\nstart_game, show_points, exit \n\n"
    answer = gets.chomp!
    if answer.downcase == "exit"
        flag = false
        return
    elsif answer.downcase == "show_points"
        points = user.get_points(name)
        print "\n\nYou have a total of #{points} points"
    elsif answer.downcase == "start_game"
        user.start_game
    end
        print default
end


