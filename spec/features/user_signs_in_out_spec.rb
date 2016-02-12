require 'spec_helper'

feature "user can sign in" do
  scenario "user can sign in successfully" do
    sign_in

    expect(page).to have_content "Signed in successfully"
    expect(page).to have_content "Sign Out"
    expect(page).to_not have_content "Sign In"
    expect(page).to_not have_content "Sign Up"
  end
  scenario "user cannot sign in if they do not provide the correct user info" do
    visit root_path
    user = FactoryGirl.create(:user)
    click_on "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: "notpassword"
    click_button "Sign In"

    expect(page).to have_content "Invalid"
    expect(page).to have_content "Email"
    expect(page).to_not have_content "Signed in successfully"
    expect(page).to_not have_content "Sign Out"
  end
  scenario "user cannot sign in if they are already signed in" do
    sign_in
    visit new_user_session_path

    expect(page).to_not have_content "Email"
    expect(page).to_not have_content "Password"
    expect(page).to_not have_content "Sign In"
  end
  scenario "user can sign out successfully" do
    sign_in
    click_on "Sign Out"

    expect(page).to have_content "Sign In"
    expect(page).to have_content "Signed out successfully"
    expect(page).to_not have_content "Sign Out"
  end
end
