require 'rails_helper'

RSpec.feature "User sees only their account" do
  before do
    @users = create_list(:user, 10)
  end

  scenario "they only have access to their account information" do
    user = @users.first
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    allow_any_instance_of(ApplicationController).to receive(:current_admin?).and_return(false)
    visit user_path(@users.last)
    expect(page).to have_content "The page you were looking for doesn't exist (404)"
  end

  context "when they are not logged in" do
    scenario "they cannot see their page" do
      user = @users.first
      visit user_path(user)
      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end
  end
end