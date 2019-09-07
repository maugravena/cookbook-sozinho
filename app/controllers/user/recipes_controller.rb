class User::RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  
  def index
    @recipes = Recipe.where('user_id = ?', current_user.id)
  end
end