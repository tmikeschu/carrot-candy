require 'rails_helper'

RSpec.feature "Registered user can logt out" do
  before do
    @user = create(:user, password: "password123")
  end

  scenario "they log out" do
    visit login_path
    fill_in "email", with: @user.email
    fill_in "password", with: "password123"
    within "form" do
      click_on "Log in"
    end
    expect(page).to have_content "Welcome, #{@user.first_name}!"
    click_on "Log out"
    expect(page).to have_content "Log in"
    expect(page).to_not have_content "Log out"
  end
end