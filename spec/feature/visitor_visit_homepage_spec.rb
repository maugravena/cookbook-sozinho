require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'Successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'Cookbook')
  end

  scenario 'and view recipe' do
    recipe = Recipe.create!(title: 'Bolo de cenoura', recipe_type: 'Sobremesa',
                        cuisine: 'Brasileira', difficulty: 'Média',
                        cook_time: '30')

    visit root_path

    expect(page).to have_css('h3', text: 'Bolo de cenoura')
    expect(page).to have_css('li', text: 'Sobremesa')
    expect(page).to have_css('li', text: 'Brasileira')
    expect(page).to have_css('li', text: 'Média')
    expect(page).to have_css('li', text: '30')
  end
end
