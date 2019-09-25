class Api::V1::ApiController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :params_required
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def params_required
    render json: {message: 'Atributos obrigatórios'}, status: 412
  end

  def not_found
  render json: {message: 'Não encontrado'}, status: 404
  end
end
