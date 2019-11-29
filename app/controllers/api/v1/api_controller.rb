module Api
  module V1
    class ApiController < ApplicationController
      rescue_from ActiveRecord::RecordInvalid, with: :params_required
      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      private

      def params_required
        render json: { message: 'Atributos obrigatórios' }, status: :precondition_failed
      end

      def not_found
        render json: { message: 'Não encontrado' }, status: :not_found
      end
    end
  end
end
