require 'rails_helper'

describe 'api edit recipe' do
  it 'successfully' do
    recipe_type = RecipeType.create(name: 'Salgada')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'email@email.com', password: '123456')
    recipe = Recipe.create(user: user, title: 'TortadeBerinjela', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Média', cook_time: 20,
                           ingredients: 'Farinha, berinjela e sal',
                           cook_method: 'Misture tudo e coloque no forno')
    
    patch api_v1_recipe_path(recipe),
          params: { recipe: { title: 'Torta de Berinjela', difficulty: 'Difícil' } }
    
    expect(response.status).to eq 202
    expect(response.body).to include 'Torta de Berinjela'
    expect(response.body).to include 'Difícil'
  end

  it 'to change status' do
    recipe_type = RecipeType.create(name: 'Salgada')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'email@email.com', password: '123456')
    recipe = Recipe.create(user: user, title: 'TortadeBerinjela', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Média', cook_time: 20,
                           ingredients: 'Farinha, berinjela e sal',
                           cook_method: 'Misture tudo e coloque no forno')
    
    patch api_v1_recipe_path(recipe),
          params: { recipe: { status: :approved } }

    expect(response.status).to eq 202
    expect(response.body).to include 'approved'
  end
end 