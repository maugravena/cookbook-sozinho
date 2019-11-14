require 'rails_helper'

feature 'user views his own recipes' do
  let(:user) { create(:user) }
  let(:cuisine) { create(:cuisine) }
  let(:recipe_type) { create(:recipe_type) }

  scenario 'successfully' do
    recipe_x = create(:recipe, recipe_type: recipe_type, cuisine: cuisine, user: user)
    recipe_y = create(:recipe, recipe_type: recipe_type, cuisine: cuisine, user: user)

    login_as user, scope: :user
    visit root_path

    #click_on 'Entrar'

    #fill_in 'Email', with: 'email@email.com'
    #fill_in 'Password', with: '123456'
    #click_on 'Log in'

    click_on 'Minhas Receitas'

    expect(page).to have_css 'h1', text: "Suas Receitas - #{user.email}"
    expect(page).to have_content recipe_x.title
    expect(page).to have_content recipe_y.title
  end

  scenario 'and must be logged in to view link' do
    visit root_path

    expect(page).to have_no_css 'a', text: 'Mindas Receitas'
  end

  scenario 'and must be logged to access from url' do
    visit user_recipes_path

    expect(current_path).to eq new_user_session_path
  end
end
