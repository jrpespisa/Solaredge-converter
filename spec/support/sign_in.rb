require "rails_helper"
include Devise::Controllers::Helpers

module SignIn

  def sign_in
    user = FactoryGirl.create(:user)
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end

end
