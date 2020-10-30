class SearchesController < ApplicationController
  def search
    @range = params[:range]
    search = params[:search]
    word = params[:word]

    case @range
    when '1'
      @posts = Post.search(search, word)
    when '2'
      @sake_breweries = SakeBrewery.search(search, word)
    else
      @users = User.search(search, word)
    end
  end
end
