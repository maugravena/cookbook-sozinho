class Api::V1::ApiController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :params_required

  private

  def params_required
    render json: 'Atributos obrigatórios', status: 412
  end
end