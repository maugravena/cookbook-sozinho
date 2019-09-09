class Api::V1::RecipesController < Api::V1::ApiController
  def show
    @recipe = Recipe.find_by!(id: params[:id])
    render json: { recipe: @recipe }, status: 202
  end

  def create
    @recipe = Recipe.create!(recipe_params)
    render json: { recipe: @recipe,
                    message: 'Receita enviada com sucesso' }, status: 201
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                   :difficulty,:cook_time, :ingredients, 
                                   :cook_method, :status, :user_id)
  end
end