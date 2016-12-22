require 'rails_helper'

RSpec.feature "User sees their points on their dashboard" do
  before do
    @user = create(:user, points: 50, redeemed_points: 30)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    allow_any_instance_of(ApplicationController).to receive(:current_admin?).and_return(false)
  end

  scenario "they can see their point statistics" do
    visit user_dashboard_path(@user)
    expect(page).to have_content "Points Available: 50"
    expect(page).to have_content "Redeemed Points: 30"
    expect(page).to have_content "All Time Points: 80"
  end
end