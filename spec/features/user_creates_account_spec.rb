require 'spec_helper'

feature "user creates a new account" do
  scenario "user successfully creates account" do
    visit root_path
    click_link "Sign Up"
    fill_in "First name", with: "John"
    fill_in "Last name", with: "Smith"
    fill_in "Email", with: "jsmith@gmail.com"
    fill_in "Site ID", with: "439873"
    fill_in "Initial Investment", with: 50000
    fill_in "user_password", with: "password"
    fill_in "Confirm Password", with: "password"
    click_button "Sign Up"

    expect(page).to have_content "Welcome! You have signed up successfully"
    expect(page).to have_content "Sign Out"
  end

  scenario "user does not successfully create account" do
    visit root_path
    click_link "Sign Up"
    click_button "Sign Up"

    expect(page).to have_content "can't be blank"
  end

  scenario "user does not properly confirm password" do
    visit root_path
    click_link "Sign Up"
    fill_in "user_password", with: "password"
    fill_in "Confirm Password", with: "pasword"
    click_button "Sign Up"

    expect(page).to have_content "doesn't match"
    expect(page).to_not have_content "Sign Out"
  end
end
