require_relative '../lib/hangman/version.rb'

class Hangman::CLI 
  @@player_scores = {}

  def welcome 
    puts @@hangman_pics[0]
    puts "Welcome to Hangman! Would you like to play?"

    while true 
      input = user_input.downcase
      if input == 'y' || input == 'yes'
        @api_call = Hangman::WordCall.new

        ask_num_players
        @@player_scores.length > 1 ? who_is_playing : @current_player = @@player_scores.keys[0]

        @game = Hangman::Game.new(@api_call.word)
        system('clear')
        prompt_guesser
        break;
      elsif input == 'n' || input == 'no'
        puts "Sorry to see you go!"
        break;
      else 
        puts "Invalid input. Please enter yes or no."
      end 
    end 
  end 

  # prompts guesser for their guess
  def prompt_guesser
    output_display
    puts @@hangman_pics[@game.guesses.length]

    incorrect_guesses_count
    display_incorrect_guesses

    puts "What letter would you like to guess?"
    input = user_input.downcase

    already_guessed?(input)

    if @game.game_over? == true
      end_game
    else
      prompt_guesser
    end 
  end 

  def start_over?
    puts "Would you like to play again? Please type 'yes' or 'no'."

    while true
      input = user_input.downcase
      if input == "yes" || input == "y"
        system('clear')

        who_is_playing if @@player_scores.length != 1
        @game = Hangman::Game.new(@api_call.word)

        prompt_guesser
        break
      elsif input == "no" || input == "n"
        system('clear')
        display_player_scores
        
        break
      else
        puts "Invalid input. Please try again."
      end
    end
  end

  def already_guessed?(letter)
    if @game.guesses.include?(letter)
      system('clear')
      puts "Oops! You already guessed that letter."
    else 
      @game.guess(letter)
    end 
  end 

  def end_game
    if !@game.display.include?("_ ")
      @@player_scores[@current_player] += 1
      
      puts output_display
      puts "You win!"
    else 
      puts "Oh no! You ran out of guesses.\n\nThe word was #{@game.word.join}\n\n"
    end 

    start_over?
  end 

  # get num of players and their names - creates key/value pairs in hash
  def ask_num_players
    puts "How many players are playing?"
    input = user_input.to_i

    input.times do 
      puts "What is your name?"
      @@player_scores[user_input] = 0
    end  
  end 

  # assigns current guesser
  def who_is_playing
    puts "Who is currently playing?"
    @current_player = user_input
  end 

  # Helper Methods
  def user_input
    @input = gets.chomp 
  end 

  # Display Methods
  def incorrect_guesses_count
    puts "Number of Incorrect Guesses: #{@game.guesses.length}"
  end

  def display_incorrect_guesses
    puts "Your Incorrect Guesses: #{@game.guesses.join(", ")}"
  end 

  def output_display
    puts @game.display.join 
  end

  def display_player_scores 
    @@player_scores.each do |player_name, win_count| 
      puts "#{player_name} won #{win_count} game(s)"
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