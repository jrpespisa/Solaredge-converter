require "rails_helper"

feature "user enters in relevant information and total savings is output" do
  scenario "user views index page" do
    sign_in

    expect(page).to have_content "Solaredge Calculator"
    expect(page).to have_content "Please enter information below"
  end
end
