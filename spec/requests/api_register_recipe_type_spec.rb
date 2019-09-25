require 'rails_helper'

describe 'api register recipe type' do
  before(:each) do 
    sign_in_basic 
    User.create(email: 'user@email.com', password: '123456')
  end

  it 'sucessfully' do
    post api_v1_recipe_types_path, 
         params: {name: 'Sobremesa'}, 
         headers: @env

    expect(response.status).to eq 201
    expect(response.body).to include 'Tipo de receita enviado com sucesso'
    expect(response.body).to include 'Sobremesa'
  end

  it "and the parameter can't be empty" do
    post api_v1_recipe_types_path, 
         params: {name: ''},
         headers: @env

    expect(response.status).to eq 412
    expect(response.body).to include 'Atributos obrigatórios'
  end
end
