module Api
  module V1
    class RecipeTypesController < ApiController
      skip_before_action :verify_authenticity_token
      before_action :check_auth, only: %i[create]

      def show
        @recipe_type = RecipeType.find(params[:id])
        @recipes = @recipe_type.recipes
        render json: { recipe_type: @recipe_type.name,
                       recipes: @recipes }, status: :accepted
      end

      def create
        @recipe_type = RecipeType.create!(recipe_type_params)
        render json: { recipe_type: @recipe_type,
                       message: 'Tipo de receita enviado com sucesso' }, status: :created
      end

      private

      def recipe_type_params
        params.permit(:name)
      end

      def check_auth
        authenticate_or_request_with_http_basic do |email, password|
          resource = User.find_by(email: email)
          resource.valid_password?(password.to_s) if sign_in :user, resource
        end
      end
    end
  end
end
