=begin 
As an admin
when I visit the rewards index
and I click "Edit" on one of the rewards
and I update its information
and I click Update rewards
then I am taken back to the index
and the information is updated
=end
require 'rails_helper'

RSpec.feature "Admin edits a reward" do
  before do
    @admin  = create(:user, role: 1)
    @user   = create(:user)
    @rewards = create_list(:reward, 10)
    visit login_path
    fill_in "email", with: @admin.email
    fill_in "password", with: @admin.password
    within "form" do
      click_on "Log in"
    end
    visit admin_rewards_path
  end

  scenario "they can update a rewards information" do
    within "li:nth-child(1)" do
      expect(page).to_not have_content "iPod"
      click_on "Edit Reward"
    end
    fill_in "reward_name", with: "iPod"  
    fill_in "reward_quantity", with: 5
    fill_in "reward_point_value", with: 20
    click_on "Update Reward"
    within "li:nth-child(2)" do 
      expect(page).to have_content "iPod"
      expect(page).to have_content 5
      expect(page).to have_content 20
    end
  end
end
