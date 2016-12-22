require 'rails_helper'

RSpec.feature "User can log in" do
  before do
    @user = create(:user, password: "password123")
  end
  
  scenario "they log in" do
    visit login_path
    fill_in "email", with: @user.email
    fill_in "password", with: "password123"
    within "form" do
      click_on "Log in"
    end
    expect(page).to have_content "Login successful!"
    expect(page).to have_content "Welcome, #{@user.first_name}"
    expect(page).to have_link "Log out", href: logout_path
  end

  context "when they are not a registered user" do
    scenario "they receive an error" do
      visit login_path
      fill_in "email", with: "t@mike.schutte"
      fill_in "password", with: "password123"
      within "form" do
        click_on "Log in"
      end
      expect(page).to have_content "Unknown email. Try again."
    end
  end

  context "when a user enters an incorrect password" do
    scenario "they receive an error" do
      visit login_path
      fill_in "email", with: @user.email
      fill_in "password", with: "password124"
      within "form" do
        click_on "Log in"
      end
      expect(page).to have_content "Incorrect password. Try again."
    end
  end
end