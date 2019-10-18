require_relative '../lib/hangman/version.rb'
require 'rest-client'

class Hangman::CLI 
  def welcome 
    puts @@hangman_pics[0]
    puts "Welcome to Hangman! Would you like to play?"

    while true 
      input = gets.chomp.downcase
      if input == 'y' || input == 'yes'
        get_word
        break;
      elsif input == 'n' || input == 'no'
        puts "Sorry to see you go!"
        break;
      else 
        puts "Invalid input. Please enter yes or no."
      end 
    end 
  end 

  def get_word 
    # words = RestClient.get('http://app.linkedin-reach.io/words?minLength=5')
    # binding.pry
    # words_arr = [] 
    # JSON.parse(words).split('').each do |word|
    #   binding.pry
    #   words_arr << word 
    # end 

    # word = words_arr.sample
    # binding.pry
    word = 'apple'
    @game = Hangman::Game.new(word)
    play_game
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
        get_word
        break
      elsif input == "no" || input == "n"
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