require 'rails_helper'

describe 'Api show recipes' do
  it 'successfully' do
    recipe_type_x = RecipeType.create(name: 'Salgada')
    recipe_type_y = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'email@email.com', password: '123456')

    recipe_x = Recipe.create(user: user, title: 'Torta de Berinjela', recipe_type: recipe_type_x,
                           cuisine: cuisine, difficulty: 'Média', cook_time: 20,
                           ingredients: 'Farinha, berinjela e sal',
                           cook_method: 'Misture tudo e coloque no forno')

    recipe_y = Recipe.create!(user: user, title: 'Bolo de cenoura', recipe_type: recipe_type_y,
                   cuisine: cuisine, difficulty: 'Média',
                   cook_time: 30, ingredients: 'farinha, ovo, cenoura',
                   cook_method: 'Misture tudo e coloque no forno', status: 'approved')
    
    get api_v1_recipes_path

    expect(response.status).to eq 202
    expect(response.body).to include recipe_x.title
    expect(response.body).to include recipe_y.title
  end

  it 'and get recipe by filter' do
    recipe_type_x = RecipeType.create(name: 'Salgada')
    recipe_type_y = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'email@email.com', password: '123456')

    recipe_x = Recipe.create(user: user, title: 'Torta de Berinjela', recipe_type: recipe_type_x,
                           cuisine: cuisine, difficulty: 'Média', cook_time: 20,
                           ingredients: 'Farinha, berinjela e sal',
                           cook_method: 'Misture tudo e coloque no forno')

    recipe_y = Recipe.create!(user: user, title: 'Bolo de cenoura', recipe_type: recipe_type_y,
                   cuisine: cuisine, difficulty: 'Média',
                   cook_time: 30, ingredients: 'farinha, ovo, cenoura',
                   cook_method: 'Misture tudo e coloque no forno', status: 'approved')
    
    get api_v1_recipes_path,
        params: { recipe: { status: :approved } }

    expect(response.status).to eq 202
    expect(response.body).to include recipe_y.title
    expect(response.body).not_to include recipe_x.title
  end

  it 'but not found' do
    get api_v1_recipes_path

    expect(response.status).to eq 404
    expect(response.body).to include 'Não encontrado'
  end
end