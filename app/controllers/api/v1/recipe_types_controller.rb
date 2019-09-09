class Api::V1::RecipeTypesController < Api::V1::ApiController
  def create
    @recipe_type = RecipeType.create!(params.require(:recipe_type).permit(:name))
    render json: { recipe_type: @recipe_type,
                    message: 'Tipo de receita enviado com sucesso' }, status: 201
  end
end