class Hangman::Game
  attr_reader :guesses, :display

  def initialize(word)
    @word = word.chars
    @display = []

    @word.length.times do 
      @display << "_ "
    end
    
    @guesses = []
  end

  # logic for guessed letter
  def guess(letter)
    if @guesses.length < 6 && @word.include?(letter)
      @word.each_with_index { |char, i| char == letter ? @display[i] = "#{letter} " : @display } 
      output_display
    elsif @guesses.length < 6 && !@word.include?(letter)
      output_display
      @guesses << letter
    end
  end

  # Helper Methods
  def output_display
    puts @display.join 
  end

  def incorrect_guesses
    puts "Number of Incorrect Guesses: #{@guesses.length}"
  end

  def display_guesses
    puts "Your Incorrect Guesses: #{@guesses.join(", ")}"
  end 
end