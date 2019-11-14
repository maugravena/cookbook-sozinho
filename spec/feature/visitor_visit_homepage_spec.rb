require 'rails_helper'

feature 'Visitor visit homepage' do
  let(:user) { create(:user) }
  let(:cuisine) { create(:cuisine) }
  let(:recipe_type) { create(:recipe_type) }

  scenario 'Successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'Cookbook')
  end

  scenario 'and view recipe' do
    recipe = create(:recipe, status: :approved)

    visit root_path

    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: recipe.cook_time)
  end

  scenario 'and views six recipes' do
    recipe_a = create(:recipe, recipe_type: recipe_type, cuisine: cuisine, status: :approved)
    recipe_b = create(:recipe, recipe_type: recipe_type, cuisine: cuisine, status: :approved)
    recipe_c = create(:recipe, recipe_type: recipe_type, cuisine: cuisine, status: :approved)
    recipe_d = create(:recipe, recipe_type: recipe_type, cuisine: cuisine, status: :approved)
    recipe_e = create(:recipe, recipe_type: recipe_type, cuisine: cuisine, status: :approved)
    recipe_f = create(:recipe, recipe_type: recipe_type, cuisine: cuisine, status: :approved)

    visit root_path
    
    expect(page).to have_content recipe_a.title
    expect(page).to have_content recipe_b.title
    expect(page).to have_content recipe_c.title
    expect(page).to have_content recipe_d.title
    expect(page).to have_content recipe_e.title
    expect(page).to have_content recipe_f.title
  end

  scenario "and don't see pending recipes" do
    recipe_x = create(:recipe, recipe_type: recipe_type, cuisine: cuisine,)
    recipe_y = create(:recipe, recipe_type: recipe_type, cuisine: cuisine, status: :approved)

    visit root_path
    
    expect(page).to have_no_text recipe_x.title

    expect(page).to have_css('h3', text: recipe_y.title)
    expect(page).to have_css('li', text: recipe_y.recipe_type.name)
    expect(page).to have_css('li', text: recipe_y.cuisine.name)
    expect(page).to have_css('li', text: recipe_y.difficulty)
    expect(page).to have_css('li', text: recipe_y.cook_time)
  end
end
