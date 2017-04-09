require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)
@@guesses_left = 5
background_color = "white"
cheat_mode = ""

get '/' do
	guess = params["guess"]
	message = check_guess(guess)
	end_message = ""
	background_color = color_guess(guess)
	erb :index, :locals => {:number => SECRET_NUMBER, :message => message, :background_color => background_color, :end_message => end_message, :cheat_mode => cheat_mode}
	
	if params["cheat"] == "true"
		cheat_mode = "Cheat mode unlocked. The secret number is: #{SECRET_NUMBER}."
	end
	if guess != nil
		if background_color == "green"
			end_message = "A new number has been generated if you would like to play again."
			@@guesses_left = 5
			SECRET_NUMBER = rand(101)
			cheat_mode = ""
		elsif @@guesses_left == 0
			end_message = "You lost! A new number has been generated if you would like to play again."
			@@guesses_left = 5
			SECRET_NUMBER = rand(101)
			cheat_mode = ""
		else
			@@guesses_left -= 1
		end
	end
	erb :index, :locals => {:number => SECRET_NUMBER, :message => message, :background_color => background_color, :end_message => end_message, :cheat_mode => cheat_mode}			
end

def check_guess(guess)
	difference = guess.to_i - SECRET_NUMBER
	if guess == nil
		"Select a number from 0 to 100."
	elsif difference > 5
		"Way too high!"
	elsif difference > 0 && difference <= 5
		"Too high!"
	elsif difference == 0
		"You got it right!"
	elsif difference < 0 && difference >= -5
		"Too low!"
	elsif difference < -5
		"Way too low!"
	end	
end

def color_guess(guess)
	difference = guess.to_i - SECRET_NUMBER
	if guess == nil
		return "white"
	elsif difference.abs > 5
		return "red"
	elsif difference.abs > 0 && difference.abs < 5
		return "palevioletred"
	elsif difference == 0
		return "green"
	end
end
