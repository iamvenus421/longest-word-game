require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @input = params[:input].upcase.split(//)
    @letters = params[:letters].upcase.split(//)
    @answer = @input.to_set.subset?(@letters.to_set)

    if @answer == true
      url = "https://wagon-dictionary.herokuapp.com/#{params[:input]}"
      html_file = URI.open(url).read
      @matching = JSON.parse(html_file)
      @result = "Congratulation! #{params[:input]} is a valid English word!" if @matching['found']
      @result = "Sorry! but #{params[:input]} doesn\'t seem to be a valid word..." unless @matching['found']
    else
      @result = "Sorry, but the #{params[:input]} can\'t be built out of #{@letters.join(' ')} "
    end
  end
end
