class Api::V1::RecipeTypesController < Api::V1::ApiController
  def show
    @recipe_type = RecipeType.find(params[:id])
    @recipes = @recipe_type.recipes
    render json: { recipe_type: @recipe_type.name,
                   recipes: @recipes }, status: 202
  end

  def create
    @recipe_type = RecipeType.create!(recipe_type_params)
    render json: { recipe_type: @recipe_type,
                   message: 'Tipo de receita enviado com sucesso' }, status: 201
  end

  private

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end
end
