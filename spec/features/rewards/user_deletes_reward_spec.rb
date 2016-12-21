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
      expect(page).to_not have @reward.name
      expect(page).to_not have_selector("li##{downcase_join_name(@reward.name)}")
    end
  end
end

