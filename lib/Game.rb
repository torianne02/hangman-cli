class Hangman::Game
  attr_reader :guesses, :display, :word

  def initialize(input)
    @word = input.chars
    @display = []

    @word.length.times do 
      @display << "_ "
    end
    
    @guesses = []
  end

  # logic for guessed letter
  def guess(letter)
    system('clear')
    if @guesses.length < 6 && @word.include?(letter)
      @word.each_with_index { |char, i| char == letter ? @display[i] = "#{letter} " : @display } 
    elsif @guesses.length < 6 && !@word.include?(letter)
      @guesses << letter
    end
  end

  def game_over?
    if !display.include?("_ ") || guesses.length == 6 
      return true
    else
      return false
    end 
  end
end