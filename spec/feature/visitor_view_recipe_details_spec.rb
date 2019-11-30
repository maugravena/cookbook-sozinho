require 'rails_helper'

feature 'Visitor view recipe details' do
  scenario 'successfully' do
    recipe = create(:recipe, status: :approved)
    
    visit root_path
    click_on recipe.title

    expect(page).to have_no_css('p', text: "Status da receita: #{recipe.status}")
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('p', text: recipe.recipe_type.name)
    expect(page).to have_css('p', text: recipe.cuisine.name)
    expect(page).to have_css('p', text: recipe.difficulty)
    expect(page).to have_css('p', text: recipe.cook_time)
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: recipe.ingredients)
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text: recipe.cook_method)
  end
end
