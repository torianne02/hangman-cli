require_relative '../lib/hangman/version.rb'

class Hangman::CLI 
  @@player_scores = {}

  def welcome 
    puts @@hangman_pics[0]
    puts "Welcome to Hangman! Would you like to play?"

    while true 
      input = gets.chomp.downcase
      if input == 'y' || input == 'yes'
        @api_call = Hangman::WordCall.new

        ask_num_players
        @@player_scores.length > 1 ? who_is_playing : @current_guesser = @@player_scores.keys[0]

        @game = Hangman::Game.new(@api_call.word)
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
    incorrect_guesses_count
    display_incorrect_guesses

    puts "What letter would you like to guess?"
    input = gets.chomp.downcase

    if @game.guesses.include?(input)
      system('clear')
      puts "Oops! You already guessed that letter."
    else 
     @game.guess(input)
    end 

    if !@game.display.include?("_ ")
      @@player_scores[@current_guesser] += 1
      puts "You win!"
      start_over?
    elsif @game.guesses.length == 6 
      puts "#{@game.word.join}"
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
        @game = Hangman::Game.new(@api_call.word)
        play_game
        break
      elsif input == "no" || input == "n"
        system('clear')

        @@player_scores.each do |player_name, win_count| 
          puts "#{player_name} won #{win_count} game(s)"
        end 
        break
      else
        puts "Invalid input. Please try again."
      end
    end
  end

  # Display Methods
  def incorrect_guesses_count
    puts "Number of Incorrect Guesses: #{@game.guesses.length}"
  end

  def display_incorrect_guesses
    puts "Your Incorrect Guesses: #{@game.guesses.join(", ")}"
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