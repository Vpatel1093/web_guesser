require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER=rand(101)

get '/' do
	guess = params["guess"]
	message = check_guess(guess)
	erb :index, :locals => {:number => SECRET_NUMBER, :message => message}
end

def check_guess(guess)
	difference = guess.to_i - SECRET_NUMBER
	if guess == nil
		""
	elsif difference > 5
		"Way too high!"
	elsif difference > 0 && difference <= 5
		"Too high!"
	elsif difference == 0
		"You got it right!" +
		"\nThe SECRET NUMBER is #{SECRET_NUMBER}."
	elsif difference < 0 && difference >= -5
		"Too low!"
	elsif difference < -5
		"Way too low!"
	end	
end
