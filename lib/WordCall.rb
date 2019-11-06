require 'httparty'

class Hangman::WordCall 

  def initialize
    @words = []
    @used_words = []

    get_words_arr
  end 

  # currently only grabs words that start with 'a'
  def get_words_arr
    start_count = 0

    keep_fetching = true

    while keep_fetching
      api_response = HTTParty.get("http://app.linkedin-reach.io/words?start=#{start_count}&count=50")

      if api_response.code != 200
        raise "#{response.code}: Failed to call LinkedIn API"
      else 
        response_arr = api_response.parsed_response.split
        response_arr.map {|word| @words << word}

        if response_arr.length < 50 || @words.length >= 1000
          keep_fetching = false
        else 
          start_count += 50
        end 
      end
    end 

    def word 
      chosen_word = @words.sample

      # prevents same word being chosen 2x in one game session
      @used_words.include?(chosen_word) ? word : chosen_word
    end 
  end
end 