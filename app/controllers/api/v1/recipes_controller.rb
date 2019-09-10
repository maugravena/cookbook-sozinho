class Api::V1::RecipesController < Api::V1::ApiController
  before_action :set_recipe, only: %i[show update destroy]

  def index
    if !params[:recipe]
      @recipes = Recipe.all
    else
      @recipes = Recipe.where(status: params[:recipe][:status])
    end
    
    if @recipes.empty?
      render json: 'Não encontrado', status: 404
    else
      render json: @recipes, status: 202
    end
  end

  def show
    render json: { recipe: @recipe }, status: 202
  end

  def create
    @recipe = Recipe.create!(recipe_params)
    render json: { recipe: @recipe,
                    message: 'Receita enviada com sucesso' }, status: 201
  end

  def update
    render json: @recipe, status: 202 if @recipe.update(recipe_params)
  end

  def destroy
    @recipe.destroy
    render json: 'Receita removida com sucesso', status: 202
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                   :difficulty,:cook_time, :ingredients, 
                                   :cook_method, :status, :user_id)
  end
end