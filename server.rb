require "sinatra"
require "pry"
require "sinatra/flash"

enable :sessions

use Rack::Session::Cookie, {
  secret: "keep_it_secret_keep_it_safe"
}

def initialize_scores
    session[:player_score] = 0
    session[:computer_score] = 0
end

def computer_choice
  shapes = {
    "r" => "rock",
    "p" => "paper",
    "s" => "scissors"
    }
  computer_shape = shapes.keys.sample
  computer_shape
end

def round_winner(player, computer)
  if player == computer
    return "tie"
  elsif player == "r" && computer == "s" ||
    player == "s" && computer == "p" ||
    player == "p" && computer == "r"
    return "player"
  elsif computer == "r" && player == "s" ||
    computer == "s" && player == "p" ||
    computer == "p" && player == "r"
    return "computer"
  end
end

def gameplay_messages(winner)
  until session[:player_score] == 2 || session[:computer_score] == 2
    if winner == "tie"
      flash[:notification] = "Uhoh, there was a tie. Choose again."
    elsif winner == "computer"
      flash[:notification] = "Computer wins this round!"
      session[:computer_score] += 1
    else
      flash[:notification] = "You won this round!"
      session[:player_score] += 1
    end
  redirect '/'
  end
end

def game_winner
  if session[:player_score] > session[:computer_score]
    flash[:notification] = "Hey, you won! Nice work. Select Rock, Paper,
    or Scissors to play again."
  else
    flash[:notification] = "The computer is victorious. But don't worry,
    there's always next time. Select Rock, Paper, or Scissors to play again."
  end
end

get '/' do
  if session[:player_score].nil? && session[:computer_score].nil?
    initialize_scores
  end

  erb :index, locals: { player_score: session[:player_score],
     computer_score: session[:computer_score], message: flash[:notification] }
end

post '/' do
  winner = round_winner(params["player_shape"], computer_choice)
  gameplay_messages(winner)
  game_winner
  initialize_scores
  redirect '/'
end
