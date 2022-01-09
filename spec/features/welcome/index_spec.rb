require 'rails_helper'

RSpec.describe 'Welcome Page' do
  it 'shows a link to sign up as a new merchant and is taken to a form' do
    vist '/'

    expect(page).to have_link("Sign Up as a new merchant!")
    click_on("Sign Up as a new merchant!")

    expect(current_path).to eq("/merchants/new")
  end
  it 'returns user to welcome page after form is complete. displays a congratulations message' do
    visit "/merchants/new"
    expect(page).to have-have_field(:merchant_name)
    username = "jeffs_hiking"
    password = "rocks"
    fill_in 'username', with: username
    fill_in 'password', with: password
    fill_in 'merchant_name', with: "Jeff's Hiking Gear"
    click_on 'Create Merchant'

    expect(current_path).to eq("/")
    expect(page).to have_content("Welcome! #{username}")
  end
end 
