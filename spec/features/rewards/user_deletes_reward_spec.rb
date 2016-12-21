=begin 
As an admin
I can delete a reward
=end
require 'rails_helper'

RSpec.feature "User deletes a reward" do
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

    scenario "they can delete a reward from the index" do
      visit admin_rewards_path
      within "li##{@reward.name.downcase.split(" ").join}" do
        click_on "Delete"
      end
      expect(current_path).to eq admin_rewards_path
      expect(page).to_not have_content @reward.name
      expect(page).to_not have_selector("li##{@reward.name.downcase.split(" ").join}")
    end
  end

  describe "as a user" do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      allow_any_instance_of(ApplicationController).to receive(:current_admin?).and_return(false)
    end

    context "when a user tries to override with a delete request" do
      scenario "they receive an error" do
        page.driver.submit :delete, admin_reward_path(@reward), {}
        expect(page).to have_content "The page you were looking for doesn't exist (404)"
        expect(User.find(@user.id)).to be_truthy
      end
    end
  end
end

