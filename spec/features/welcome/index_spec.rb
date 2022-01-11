require 'rails_helper'

RSpec.describe 'Welcome Page' do
  it 'shows a link to sign up as a new merchant and is taken to a form' do
    visit '/'

    expect(page).to have_link("Sign up as a new merchant!")
    click_on("Sign up as a new merchant!")

    expect(current_path).to eq("/merchants/new")
  end
  it 'returns user to welcome page after form is complete. displays a congratulations message' do
    visit "/merchants/new"
    # save_and_open_page
    expect(page).to have_field(:merchant_name)
    username = "jeffs_hiking"
    password = "rocks"
    fill_in 'merchant_username', with: username
    fill_in 'merchant_password', with: password
    fill_in 'merchant_name', with: "Jeff's Hiking Gear"
    click_on 'Create Merchant'

    expect(current_path).to eq("/")
    expect(page).to have_content("Welcome #{username}!")
  end
end
