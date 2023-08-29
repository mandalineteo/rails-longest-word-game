require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabets = ('A'..'Z').to_a
    @letters = []
    10.times do
      @letters << alphabets[rand(26)]
    end
  end

  def score
    answer = params[:score].upcase
    letters = params[:letters].chars()
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    response = URI.open(url).read
    hash = JSON.parse(response)

    if hash["found"] == false
      @message = "Sorry, but #{answer} does not seem to be a valid English word. Please try again."
    else
      answer_letter = answer.chars()
      @score = true
      answer_letter.each do |letter|
        if letters.include?(letter)
          index = letters.index(letter)
          letters.delete_at(index)
        else
          @score = false
        end
      end
      if @score
        @message = "Congratulations! #{answer} is a valid English word and is part of the combination!"
      else
        @message = "Sorry, some letters in #{answer} are not part of the letters given."
      end
    end
  end
end
