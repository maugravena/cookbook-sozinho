class HomeController < ApplicationController
  def index
    @recipes = Recipe.all
  end
  
  def search
    @recipes = Recipe.where('title LIKE  ?', "#{params[:q]}%")
    render :index
  end
end
