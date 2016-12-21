=begin 
As an admin
If I go to the new reward page
and enter its information
and click "Add Reward"
I am taken to the rewards page
and that reward shows up
=end

require 'rails_helper'

RSpec.feature "Admin creates a reward" do
  before do
    @admin = create(:user, role: 1)
    visit login_path
    fill_in "email", with: @admin.email
    fill_in "password", with: @admin.password
    within "form" do
      click_on "Log in"
    end
  end
    
  
  scenario "they create a reward" do
    click_on "Add Reward"
    fill_in "reward_name", with: "iPod"  
    fill_in "reward_quantity", with: 5
    fill_in "reward_point_value", with: 20
    click_on "Add Reward"
    @reward = Reward.first
    expect(current_path).to eq rewards_path
    expect(page).to have_link @reward.name, href: reward_path(@reward)    
  end

  xcontext "when they forget information" do
    scenario "they receive an error" do
    end
  end

  xcontext "when they enter a duplicate name" do
    scenario "they recevie an error" do
    end
  end
end