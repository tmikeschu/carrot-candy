require 'rails_helper'

RSpec.feature "Admin creates a user" do
  before do
    @admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    allow_any_instance_of(ApplicationController).to receive(:current_admin?).and_return(true)
  end

  scenario "they create a user" do
    visit new_admin_user_path
    fill_in "user_first_name", with: "Mike"
    fill_in "user_last_name", with: "Schutte"
    fill_in "user_email", with: "t@mike.schutte"
    fill_in "user_password", with: "password123"
    click_on "Create Account"
    expect(page).to have_content "Account created!"
    expect(page).to have_content "Mike Schutte"
    expect(page).to have_content "t@mike.schutte"
    expect(page).to have_content "Points: 0"
    expect(page).to have_content "Redeemed Points: 0"
  end

  context "when they forget information" do
    scenario "they see an error message" do
      visit new_admin_user_path
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
      visit new_admin_user_path
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
      visit new_admin_user_path
      fill_in "user_first_name", with: "Mike"
      fill_in "user_last_name", with: "Schutte"
      fill_in "user_email", with: "t@mike.schutte"
      fill_in "user_password", with: "pass"
      click_on "Create Account"
      expect(page).to have_content "Whoops!"
      expect(page).to have_content "Password is too short (minimum is 10 characters)"
    end
  end

  context "when a user tries to create an account" do
    scenario "they are unable" do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      allow_any_instance_of(ApplicationController).to receive(:current_admin?).and_return(false)
      visit new_admin_user_path
      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end
  end
end