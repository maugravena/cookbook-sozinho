require 'rails_helper'

describe 'register recipes from api' do
  it 'successfully' do
    user = User.create(email: 'usuario@email.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')

    post api_v1_recipes_path,
         params: { recipe: { title: 'Bolo de cenoura', difficulty: 'Médio', 
                             user_id: user.id, recipe_type_id: recipe_type.id,
                             cuisine_id: cuisine.id, cook_time: 50,
                             ingredients: 'Farinha, açucar, cenoura',
                             cook_method: 'Misture tudo e coloque no forno' }}
    
    expect(response.status).to eq 201
    expect(response.body).to include 'Receita enviada com sucesso'
    expect(response.body).to include 'Bolo de cenoura'
  end

  it 'and must send all attribute' do
    post api_v1_recipes_path,
         params: { recipe: { title: '', difficulty: '', 
                             user_id: '', recipe_type_id: '',
                             cuisine_id: '', cook_time: '',
                             ingredients: '',
                             cook_method: '' }}
    
    expect(response.status).to eq 412
    expect(response.body).to include 'Todos atributos são obrigatórios'
  end
end