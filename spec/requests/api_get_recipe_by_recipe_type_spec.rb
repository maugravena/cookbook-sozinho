require 'rails_helper'

describe 'Api can get recipes by recipe type' do
  it 'successfully' do
    user = User.create(email: 'usuario@email.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Salgada')
    cuisine = Cuisine.create(name: 'Brasileira')
    
    recipe_x = Recipe.create(user: user, title: 'Torta de Berinjela', 
                             recipe_type: recipe_type, cuisine: cuisine, 
                             difficulty: 'Média', cook_time: 20,
                             ingredients: 'Farinha, berinjela e sal',
                             cook_method: 'Misture tudo e coloque no forno')
      
    recipe_y = Recipe.create(user: user, title: 'Lasanha', 
                             recipe_type: recipe_type, cuisine: cuisine, 
                             difficulty: 'Média', cook_time: 20,
                             ingredients: 'Farinha, queijo e sal',
                             cook_method: 'Misture tudo e coloque no forno')
        
    recipe_z = Recipe.create(user: user, title: 'Macarronada', 
                             recipe_type: recipe_type, cuisine: cuisine, 
                             difficulty: 'Média', cook_time: 20,
                             ingredients: 'Macarrão, queijo e molho',
                             cook_method: 'Misture tudo e coloque na panela')
          
    get api_v1_recipe_type_path(recipe_type)

    expect(response.status).to eq 202
    expect(response.body).to include recipe_type.name
    expect(response.body).to include recipe_x.title
    expect(response.body).to include recipe_y.title
    expect(response.body).to include recipe_z.title
  end
end