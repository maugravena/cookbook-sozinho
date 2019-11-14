class HomeController < ApplicationController
  def index
    @recipes = Recipe.last(6)
  end
  
  def search
    @recipes = Recipe.where('title LIKE  ?', "#{params[:q]}%")
    render :index
  end
end
