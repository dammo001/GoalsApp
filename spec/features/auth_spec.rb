require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before :each do
    visit new_user_url
  end

  it "shows username on the homepage after signup" do
    fill_in "Username", with: "person"
    fill_in "Password", with: "123456"
    click_button "Sign Up"
    expect(current_path).to eq(users_path)
    expect(page).to have_content("person")
  end

  it "validates the length of the password" do
    fill_in "Username", with: "user123"
    fill_in "Password", with: "1"
    click_button "Sign Up"
    expect(page).to have_content("Password is too short")
  end
end

feature "logging in" do
  before :each do
     sign_up
     visit new_session_url
   end

  it "shows username on the homepage after login" do
    fill_in "Username", with: "user"
    fill_in "Password", with: "password"
    click_button "Sign In"
    expect(current_path).to eq(users_path)
    expect(page).to have_content("user")
  end

  it "validates password length" do
    fill_in "Username", with: "user123"
    fill_in "Password", with: "1"
    click_button "Sign In"
    expect(page).to have_content("Username and password combination doesn't exist")
  end

  it "has a logout button after signed in" do
    fill_in "Username", with: "user"
    fill_in "Password", with: "password"
    click_button "Sign In"
    expect(current_path).to eq(users_path)
    expect(page).to have_button("Sign Out")
  end

end

feature "logging out" do
    before :each do
      login_user
    end

  it "doesn't show username on the homepage after logout" do
    click_button "Sign Out"
    expect(current_path).to eq(new_session_path)
    expect(page).to have_link("Sign In")
    expect(page).to have_link("Sign Up")
  end

  it "shouldn't be able to visit users index when logged out" do
    click_button "Sign Out"
    visit users_url
    expect(current_url).to eq(new_session_url)
  end
end
