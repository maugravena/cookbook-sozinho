require 'rails_helper'

describe 'Get recipe details' do
  it 'successfully' do
    recipe_type = RecipeType.create(name: 'Salgada')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'email@email.com', password: '123456')
    recipe = Recipe.create(user: user, title: 'Torta de Berinjela', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Média', cook_time: 20,
                           ingredients: 'Farinha, berinjela e sal',
                           cook_method: 'Misture tudo e coloque no forno')
    
    get api_v1_recipe_path(recipe)

    expect(response.status).to eq 202
    expect(response.body).to include recipe.title 
  end

  it 'and fails if find' do
    get api_v1_recipe_path(id: 000)
    
    expect(response.status).to eq 404
    expect(response.body).to include 'Não encontrado'
  end
end