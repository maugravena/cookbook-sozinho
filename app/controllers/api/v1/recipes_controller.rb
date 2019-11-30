module Api
  module V1
    class RecipesController < ApiController
      skip_before_action :verify_authenticity_token
      before_action :set_recipe, only: %i[show update destroy]
      before_action :check_auth, only: %i[create update]

      def index
        @recipes = if !params[:recipe]
                     Recipe.all
                   else
                     Recipe.where(status: params[:recipe][:status])
                   end

        if @recipes.empty?
          render json: 'Não encontrado', status: :not_found
        else
          render json: @recipes, status: :accepted
        end
      end

      def show
        render json: @recipe, status: :accepted
      end

      def create
        @recipe = Recipe.create!(recipe_params)
        render json: { recipe: @recipe,
                       message: 'Receita enviada com sucesso' }, status: :created
      end

      def update
        render json: @recipe, status: :accepted if @recipe.update(recipe_params)
      end

      def destroy
        @recipe.destroy
        render json: 'Receita removida com sucesso', status: :accepted
      end

      private

      def set_recipe
        @recipe = Recipe.find(params[:id])
      end

      def check_auth
        authenticate_or_request_with_http_basic do |email, password|
          resource = User.find_by(email: email)
          resource.valid_password?(password.to_s) if sign_in :user, resource
        end
      end

      def recipe_params
        params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                       :difficulty, :cook_time, :ingredients,
                                       :cook_method, :status, :user_id)
      end
    end
  end
end
