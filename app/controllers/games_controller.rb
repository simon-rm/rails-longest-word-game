require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = session[:letters] = generate_grid(10)
    session[:score] = 0 if session[:score].nil?
  end

  def score
    @word = params[:word]
    @letters = session[:letters]
    @word_in_grid = word_in_grid?(@word, @letters)
    @found = found? @word
    (session[:score] += @word.length) if @word_in_grid && @found
    @score = session[:score]
  end
end

def generate_grid(grid_size)
  grid_size.times.map { ('A'..'Z').to_a.sample }
end

def word_in_grid?(word, grid)
  word.upcase.chars.none? do |letter|
    grid.delete_at(grid.index(letter) || grid.length).nil? # clever!
  end
end

def found?(word)
  api_url = "https://wagon-dictionary.herokuapp.com/#{word}"
  word_info = JSON.parse URI.open(api_url).read
  word_info['found']
end
