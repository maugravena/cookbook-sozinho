require 'rails_helper'

feature 'Admin moderates recipes' do
  let(:admin) { create(:user, admin: true) }

  scenario 'to post' do
    created_recipes = create_pair(:recipe)
    
    login_as admin, scope: :user
    visit root_path

    click_on 'Receitas pendentes'
    click_on created_recipes[0].title
    
    choose 'recipe_status_approved'
    click_on 'Enviar'

    expect(page).to have_text 'Receita atualizada com sucesso'
    expect(page).to have_text 'approved'
  end

  scenario 'to reject' do
    created_recipes = create_pair(:recipe)
    
    login_as admin, scope: :user
    visit root_path

    click_on 'Receitas pendentes'
    click_on created_recipes[1].title
    
    choose 'recipe_status_rejected'
    click_on 'Enviar'

    expect(page).to have_text 'Receita atualizada com sucesso'
    expect(page).to have_text 'rejected'
  end
end
