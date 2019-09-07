class CuisinesController < ApplicationController 
  def new
    @cuisine = Cuisine.new
  end

  def create 
    @cuisine = Cuisine.create(params.require(:cuisine).permit(:name))

    if @cuisine.save
      redirect_to root_path, notice: 'Cozinha enviada com sucesso'
    else
      if @cuisine.errors.details[:name][0][:error] == :taken
        flash.now[:alert] = 'Essa cozinha já existe'
      else
        flash.now[:alert] = 'Campo Obrigatório'
      end
      render :new
    end
  end
end