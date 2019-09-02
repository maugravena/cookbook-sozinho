class HomeController < ApplicationController
  def index
    if params[:q]
      @recipes = Recipe.where('title LIKE  ?', "#{params[:q]}%")
    else
      @recipes = Recipe.all
    end
  end
end
