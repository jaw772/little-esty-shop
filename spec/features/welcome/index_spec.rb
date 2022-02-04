require 'rails_helper'

RSpec.describe 'Welcome Page' do
  it 'shows a link to sign up as a new user and is taken to a form' do
    visit '/'

    expect(page).to have_link("Sign up as a new user!")
    click_on("Sign up as a new user!")

    expect(current_path).to eq("/users/new")
  end
  it 'returns user to welcome page after form is complete. displays a congratulations message' do
    visit "/users/new"
    # save_and_open_page
    expect(page).to have_field(:user_username)
    username = "jeffs_hiking"
    password = "rocks"
    fill_in 'user_username', with: username
    fill_in 'user_password', with: password
    # fill_in 'user_name', with: "Jeff's Hiking Gear"
    click_on 'Create User'

    expect(current_path).to eq("/")
    expect(page).to have_content("Welcome #{username}!")
  end

  it 'keeps the user logged in after registering' do
    visit "/users/new"

    username = "jeffs_hiking"
    password = "rocks"
    fill_in 'user_username', with: username
    fill_in 'user_password', with: password
    click_on 'Create User'

    visit "/users/profile"

    expect(page).to have_content("Hello #{username}!")
  end

  it 'displays a link for current users to login' do
    user = User.create(username: "jeffs_hiking", password: "rocks")

    visit "/"
    click_on "I already have an account"
    expect(current_path).to eq("/login")

    fill_in 'user_username', with: user.username
    fill_in 'user_password', with: password
    click_on 'Log In'

    expect(current_path).to eq("/")

    expect(page).to have_content("Welcome #{user.username}!")
    expect(page).to have_link("Log out")
    expect(page).to_not have_link("Register as a User")
    expect(page).to_not have_link("I already have an account")
  end 

end
