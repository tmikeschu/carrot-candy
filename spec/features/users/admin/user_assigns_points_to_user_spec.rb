require 'rails_helper'

RSpec.feature "User assigns points to user" do
  before do
    @rewards = create_list(:reward, 10)
    @reward = @rewards.first
    @admin  = create(:user, role: 1)
    @user   = create(:user)
  end

  describe "as an admin" do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      allow_any_instance_of(ApplicationController).to receive(:current_admin?).and_return(true)
    end

    scenario "they assign points to a default user" do
      expect(@user.points).to eq 0
      visit admin_users_path
      click_on @user.name
      click_on "Add or Remove Points"

      expect(current_path).to eq edit_admin_user_path(@user)
      fill_in "user_points", with: 50
      click_on "Update Points"
      
      @user.reload
      expect(current_path).to eq admin_users_path
      expect(@user.points).to eq 50
      expect(page).to have_content "50 points added for #{@user.name}"
    end
  end

  describe "as a user" do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      allow_any_instance_of(ApplicationController).to receive(:current_admin?).and_return(false)
    end

    scenario "they cannot assign points to a user" do
      visit edit_admin_user_path(@user)
      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end

    scenario "they do not see an add points link on their page" do
      visit user_path(@user)
      expect(page).to_not have_link "Add Points", edit_admin_user_path(@user)
    end

    scenario "they do not have access to the admin user show page" do
      visit admin_user_path(@user)
      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end
  end
end