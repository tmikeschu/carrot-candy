require 'rails_helper'

RSpec.feature "Visit can create an account" do
  scenario "they create an account" do
    visit new_user_path
    fill_in "user_first_name", with: "Mike"
    fill_in "user_last_name", with: "Schutte"
    fill_in "user_email", with: "t@mike.schutte"
    fill_in "user_password", with: "password123"
    click_on "Create Account"
    expect(page).to have_content "Account created!"
    expect(page).to have_content "Welcome, Mike!"
  end

  context "when they forget information" do
    scenario "they see an error message" do
      visit new_user_path
      fill_in "user_first_name", with: ""
      fill_in "user_email", with: ""
      fill_in "user_password", with: ""
      click_on "Create Account"
      expect(page).to have_content "First name can't be blank"
      expect(page).to have_content "Email can't be blank"
      expect(page).to have_content "Password can't be blank"
      expect(page).to have_content "Whoops!"
    end
  end

  context "when they enter an existing email" do
    scenario "they see an error message" do
      User.create(first_name: "Mike", last_name: "Schutte", email: "t@mike.schutte", password: "password123")
      visit new_user_path
      fill_in "user_first_name", with: "Mike"
      fill_in "user_last_name", with: "Schutte"
      fill_in "user_email", with: "t@mike.schutte"
      fill_in "user_password", with: "password123"
      click_on "Create Account"
      expect(page).to have_content "Whoops!"
      expect(page).to have_content "Email has already been taken"
    end
  end

  context "when they enter too small a password" do
    scenario "they see an error message" do
      visit new_user_path
      fill_in "user_first_name", with: "Mike"
      fill_in "user_last_name", with: "Schutte"
      fill_in "user_email", with: "t@mike.schutte"
      fill_in "user_password", with: "pass"
      click_on "Create Account"
      expect(page).to have_content "Whoops!"
      expect(page).to have_content "Password is too short (minimum is 10 characters)"
    end
  end
end