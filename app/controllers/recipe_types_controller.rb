class RecipeTypesController < ApplicationController
  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.create(params.require(:recipe_type).permit(:name))

    if @recipe_type.save
      redirect_to root_path, notice: 'Tipo de receita enviado com sucesso'
    else
      flash.now[:alert] = if @recipe_type.errors.details[:name][0][:error] == :taken
                            'Esse tipo de receita já existe'
                          else
                            'Campo Obrigatório'
                          end
      render :new
    end
  end
end
