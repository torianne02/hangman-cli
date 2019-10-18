require_relative '../lib/hangman/version.rb'
require 'rest-client'

class Hangman::CLI 
  def call  
    # words = RestClient.get('http://app.linkedin-reach.io/words?minLength=5')
    # binding.pry
    # words_arr = [] 
    # JSON.parse(words).split('').each do |word|
    #   binding.pry
    #   words_arr << word 
    # end 

    # word = words_arr.sample
    # binding.pry
    puts HANGMANPICS[0]
    puts "Welcome to Hangman! Would you like to play?"

    while true 
      input = gets.chomp.downcase
      if input == 'y' || input == 'yes'
        word = 'apple'
        @game = Hangman::Game.new(word)
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

  # starts game
  def play_game
    puts "Let's Get Started!"
    @game.output_display

    prompt_guesser
  end

  # prompts guesser for their guess
  def prompt_guesser
    puts HANGMANPICS[@game.guesses.length]
    @game.incorrect_guesses
    @game.display_guesses

    puts "What letter would you like to guess?"
    input = gets.chomp.downcase
    @game.guess(input)

    if !@game.display.include?("_ ")
      puts "You win!"
    elsif @game.guesses.length == 6 
      puts "Secret Keeper Wins!"
    else
      prompt_guesser
    end 
  end 


  # ART
  HANGMANPICS = ['
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