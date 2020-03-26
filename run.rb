require_relative './config/environment'


puts "Welcome to Random Trivia!\n\n"
puts "In this game, you woule be asked a series of questions \n\nIf you get the answer correct you get +100 points, however if you fail
you will lose 100 points!\n\n"
flag = true
startmessage = false
name = 0

def new_user(name)
    return User.find_or_create_by(name: name)
  end

if startmessage == false
    puts "Please enter your username or type exit to quit!"
end
answer = gets.chomp!

if answer.downcase == "exit"
    flag = false
elsif startmessage == false
    name = answer
    user = new_user(answer)
    startmessage = true
    puts "Thank you #{name}! \n\nYou have these commands \n\nstart_game - Starts your random trivia game!
    \n\nshow_points - Shows your total point for all your games!
    \n\nexit - Quit the game!
    \n\nWhat would you like to do?"
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


