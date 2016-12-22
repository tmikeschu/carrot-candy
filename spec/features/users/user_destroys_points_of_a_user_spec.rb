=begin 
As an admin
I can remove points from a user
=end

require 'rails_helper'

RSpec.feature "User destroys points from a user" do
  before do
    @rewards = create_list(:reward, 10)
    @reward = @rewards.first
    @admin  = create(:user, role: 1)
    @user   = create(:user, points:  50)
  end

  describe "as an admin" do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      allow_any_instance_of(ApplicationController).to receive(:current_admin?).and_return(true)
    end

    scenario "they destroy a user's points" do
      expect(@user.points).to eq 50
      visit admin_users_path
      click_on @user.name
      click_on "Remove Points"

      expect(current_path).to eq "/admin/users/2/remove-points"
      fill_in "user_points", with: 30
      click_on "Update Points"
      
      @user.reload
      expect(current_path).to eq admin_users_path
      expect(@user.points).to eq 20
      expect(page).to have_content "30 points removed from #{@user.name}"
    end

    xcontext "when they try to remove negative points" do
      scenario "they are brought back to the user show page with an error showing" do
        @user.points = 50
        @user.save
        expect(@user.points).to eq 50
        visit admin_users_path
        click_on @user.name
        click_on "Delete Points"

        expect(current_path).to eq edit_admin_user_path(@user)
        fill_in "user_points", with: -30
        click_on "Update Points"

        expect(current_path).to eq admin_user_path(@user)
        expect(page).to have_content "Whoops! Can't remove negative points. If you want to add points, click 'Add Points'"
        @user.reload
        expect(@user.points).to eq 50
      end
    end
  end

  xdescribe "as a user" do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      allow_any_instance_of(ApplicationController).to receive(:current_admin?).and_return(false)
    end

    scenario "they do not see an remove points link on their page" do
      visit user_path(@user)
      expect(page).to_not have_link "Remove Points", edit_admin_user_path(@user)
    end
  end
end