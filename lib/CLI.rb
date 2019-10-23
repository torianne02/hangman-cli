require_relative '../lib/hangman/version.rb'

class Hangman::CLI 
  @@player_scores = {}

  def welcome 
    puts @@hangman_pics[0]
    puts "Welcome to Hangman! Would you like to play?"

    while true 
      input = gets.chomp.downcase
      if input == 'y' || input == 'yes'
        api_call = Hangman::WordCall.new
        ask_num_players
        who_is_playing
        @game = Hangman::Game.new(api_call.word)
        play_game
        break;
      elsif input == 'n' || input == 'no'
        puts "Sorry to see you go!"
        break;
      else 
        puts "Invalid input. Please enter yes or no."
      end 
    end 
  end 

  def ask_num_players
    puts "How many players are playing?"
    input = gets.chomp.to_i

    input.times do 
      puts "What is your name?"
      player_input = gets.chomp
      @@player_scores[player_input] = 0
    end  
  end 

  def who_is_playing
    puts "Who is currently playing?"
    @current_guesser = gets.chomp
  end 

  # starts game
  def play_game
    puts "Let's Get Started!"
    @game.output_display

    prompt_guesser
  end

  # prompts guesser for their guess
  def prompt_guesser
    puts @@hangman_pics[@game.guesses.length]
    @game.incorrect_guesses
    @game.display_guesses

    puts "What letter would you like to guess?"
    input = gets.chomp.downcase
    @game.guess(input)

    if !@game.display.include?("_ ")
      @@player_scores[@current_guesser] += 1
      puts "You win!"
      start_over?
    elsif @game.guesses.length == 6 
      puts "Secret Keeper Wins!"
      start_over?
    else
      prompt_guesser
    end 
  end 

  def start_over?
    puts "Would you like to play again? Please type 'yes' or 'no'."
    
    while true
      input = gets.chomp.downcase
      if input == "yes" || input == "y"
        system('clear')

        who_is_playing
        Hangman::Game.new(api_call.word)
        break
      elsif input == "no" || input == "n"
        system('clear')

        @@player_scores.each do |player_name, win_count| 
          puts "#{player_name} won #{win_count} game(s)."
        end 

        puts "We're sad to see you go. Goodbye."
        break
      else
        puts "Invalid input. Please try again."
      end
    end
  end

  # ART
  @@hangman_pics = ['
    +---+
    |   |
        |
        |
        |
        |
  =========', '
    +---+
    |   |
    O   |
        |
        |
        |
  =========', '
    +---+
    |   |
    O   |
    |   |
        |
        |
  =========', '
    +---+
    |   |
    O   |
   /|   |
        |
        |
  =========', '
    +---+
    |   |
    O   |
   /|\  |
        |
        |
  =========', '
    +---+
    |   |
    O   |
   /|\  |
   /    |
        |
  =========', '
    +---+
    |   |
    O   |
   /|\  |
   / \  |
        |
  =========']
end