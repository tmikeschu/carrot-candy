require 'rails_helper'

RSpec.feature "User sees their dashboard" do
  before do
    @user = create(:user_with_rewards, points: 50)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    allow_any_instance_of(ApplicationController).to receive(:current_admin?).and_return(false)
  end

  scenario "they can see their point statistics" do
    visit user_dashboard_path(@user)
    expect(page).to have_content "Points Available"
    expect(page).to have_content "Redeemed Points"
    expect(page).to have_content "All Time Points"
    within "tbody" do
      expect(page).to have_content @user.points
      expect(page).to have_content @user.redeemed_points
      expect(page).to have_content @user.total_points
    end
  end

  scenario "they can see their rewards" do
    visit user_dashboard_path(@user)
    expect(page).to have_content "Rewards"
    expect(page).to have_selector("body > ul > li", count: 10)
  end
end