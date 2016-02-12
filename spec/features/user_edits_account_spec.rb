require 'rails_helper'

feature "user edits account info" do
  scenario "user successfully edits account information" do
    sign_in
    click_on "Edit Account"
    fill_in "Email", with: "diff-email@gmail.com"
    fill_in "First Name", with: "Joe"
    fill_in "Last Name", with: "Stone"
    fill_in "Current Password", with: "password"
    click_button "Update"

    expect(page).to have_content "Joe Stone"
    expect(page).to have_content "Your account has been updated successfully."
    expect(page).to have_content "Sign Out"
  end

  scenario "user does not specify the correct password" do
    sign_in
    click_on "Edit Account"
    fill_in "Email", with: "diff-email@gmail.com"
    fill_in "First Name", with: "Joe"
    fill_in "Last Name", with: "Stone"
    fill_in "Current Password", with: "anotherpassword"
    click_button "Update"

    expect(page).to have_content "Current password is invalid"
  end

end
