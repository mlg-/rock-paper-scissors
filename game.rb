def init
  shapes = {
    "r" => "rock",
    "p" => "paper",
    "s" => "scissors"}

  player_score = 0
  comp_score = 0
end

def gameplay
  until player_score == 2 || comp_score == 2
    puts "Player Score:  #{player_score} | Computer Score:  #{comp_score}"
    puts "Choose rock (r), paper (p), or scissors (s):"

    comp_shape = shapes.keys.sample
    player_shape = gets.chomp

      until shapes.keys.include? player_shape
        puts "Illegal character. Try again."
        player_shape = gets.chomp
      end

    cs = shapes[comp_shape]
    ps = shapes[player_shape]

    puts "Player chose: #{ps}"
    puts "Computer chose: #{cs}"

    if ps == cs
      puts "Tie, choose again.\n\n"
    elsif ps == "rock" && cs == "scissors"
      puts "Rock beats scissors, player wins the round.\n\n"
      player_score += 1
    elsif ps == "scissors" && cs == "paper"
      puts "Scissors beat paper, player wins the round.\n\n"
      player_score += 1
    elsif ps == "paper" && cs == "rock"
      puts "Paper beats rock, player wins the round.\n\n"
      player_score += 1
    elsif cs == "rock" && ps == "scissors"
      puts "Rock beats scissors, computer wins the round.\n\n"
      comp_score += 1
    elsif cs == "scissors" && ps == "paper"
      puts "Scissors beat paper, computer wins the round.\n\n"
      comp_score += 1
    elsif cs == "paper" && ps == "rock"
      puts "Paper beats rock, computer wins the round.\n\n"
      comp_score += 1
    end

  end # end until
end # end gameplay function

def winner
  if comp_score > player_score
    puts "Computer Wins!"
  else
    puts "Player Wins!"
  end
end

init
gameplay
winner
