require 'rails_helper'

describe 'register recipes from api' do
  before(:each) do 
    sign_in_basic 
    create(:user, email: 'user@email.com')
  end

  it 'successfully' do
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)

    post api_v1_recipes_path,
         params: { recipe: { title: 'Bolo de cenoura', difficulty: 'Médio', 
                             user_id: 1, recipe_type_id: recipe_type.id,
                             cuisine_id: cuisine.id, cook_time: 50,
                             ingredients: 'Farinha, açucar, cenoura',
                             cook_method: 'Misture tudo e coloque no forno' }},
        headers: @env
    
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
                             cook_method: '' }},
         headers: @env
    
    expect(response.status).to eq 412
    expect(response.body).to include 'Atributos obrigatórios'
  end
end
