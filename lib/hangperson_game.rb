class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  

  
  def initialize(word)
    @word = word.downcase
    @guesses = ""
    @wrong_guesses = ""
  end
  
  def guess(char)
    raise ArgumentError, 'Argument error' if char.nil? || char.empty? || char.downcase == char.upcase 
    if @word.include?char.downcase
      if @guesses.include? char.downcase
        return false
      else
        @guesses << char.downcase
        return true
      end
      
    else
      
      if @wrong_guesses.include? char.downcase
        return false
      else
        @wrong_guesses << char.downcase
        return true
      end
    end
  end
  
  def word_with_guesses
    result = ""
    @word.each_char do |char| 
      if @guesses.include?char
        result << char
      else
        result << "-"
      end
    end
    result
  end
  
  def check_win_or_lose
    if word_with_guesses.include? "-"
      if @wrong_guesses.length>=7 
        return :lose
      else 
        return :play
      end
    else
      return :win    
    end
  end
  

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
