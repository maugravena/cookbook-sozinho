class Api::V1::RecipeTypesController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token
  before_action :check_auth, only: %i[create]

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
    params.permit(:name)
  end

  def check_auth
    authenticate_or_request_with_http_basic do |username,password|
      resource = User.find_by_email(username)
      if resource.valid_password?(password.to_s)
        sign_in :user, resource
      end
    end
  end
end
