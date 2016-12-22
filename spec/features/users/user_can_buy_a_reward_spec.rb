=begin 
As a user
when I visit a reward index
  or a show page
i can click "buy"
and go to a buy page

=end

require 'rails_helper'

RSpec.feature "User buys a reward" do
  before do
    @user = create(:user, points: 50)
    @rewards = create_list(:reward, 10)
    @reward = @rewards.first
    @reward.point_value = 30
    @reward.save
    @reward2 = @rewards.last
    @reward2.point_value = 100
    @reward.save
  end

  context "when they are on the index page" do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      allow_any_instance_of(ApplicationController).to receive(:current_admin?).and_return(false)
    end 

    scenario "they can buy a reward" do
      visit user_path(@user)
      expect(page).to_not have_content @reward.name
      
      visit rewards_path
      within "##{@reward.name.downcase.split(" ").join}" do
        click_on "Buy"
      end

      expect(page).to have_content "Your point total: 50"
      expect(page).to have_content "Cost of #{@reward.name}: #{@reward.point_value}"
      expect(page).to have_content "Number of these left: #{@reward.quantity}"
      click_on "Confirm Purchase"
      
      expect(current_path).to eq user_path(@user)
      expect(page).to have_content @reward.name
      expect(@user.points).to eq 20
      expect(@user.redeemed_points).to eq 30
    end

    context "when they do not have enough points" do
      scenario "they see an error" do
        visit user_path(@user)
        expect(page).to_not have_content @reward2.name
        
        visit rewards_path
        within "##{@reward2.name.downcase.split(" ").join}" do
          click_on "Buy"
        end

        expect(page).to have_content "Whoops! You do not have enough points for that reward."
      end
    end
  end
end