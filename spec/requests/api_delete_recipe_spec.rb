require 'rails_helper'

describe 'api remove recipe' do
  it 'successfully' do
    recipe_type = RecipeType.create(name: 'Salgada')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'email@email.com', password: '123456')
    recipe = Recipe.create(user: user, title: 'TortadeBerinjela', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Média', cook_time: 20,
                           ingredients: 'Farinha, berinjela e sal',
                           cook_method: 'Misture tudo e coloque no forno')
    
    delete api_v1_recipe_path(recipe)

    expect(response.status).to eq 202
    expect(response.body).to include 'Receita removida com sucesso'
  end

  it 'and pass invalid id' do
    recipe_type = RecipeType.create(name: 'Salgada')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'email@email.com', password: '123456')
    recipe = Recipe.create(user: user, title: 'TortadeBerinjela', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Média', cook_time: 20,
                           ingredients: 'Farinha, berinjela e sal',
                           cook_method: 'Misture tudo e coloque no forno')
    
    delete api_v1_recipe_path(id: 0000)
    
    expect(response.status).to eq 404
    expect(response.body).to include 'Não encontrado'
  end
end