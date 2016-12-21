require 'rails_helper'

RSpec.feature "User sees all rewards" do
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

    scenario "they can see a CRUD list of rewards" do
      visit admin_rewards_path
      expect(page).to have_selector("body > ul > li", count: 10)
      within "li##{@reward.name.downcase.split(" ").join}" do
        expect(page).to have_link "Edit", href: edit_admin_reward_path(@reward)
        expect(page).to have_link "Delete", href: admin_reward_path(@reward)
        expect(page).to have_link @reward.name, href: admin_reward_path(@reward)
        expect(page).to_not have_link "Buy", href: "/buy/#{@reward.id}"
      end
    end
  end

  describe "as a user" do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_admin?).and_return(false)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    scenario "they can see a list of rewards" do
      visit rewards_path
      expect(page).to have_selector("body > ul > li", count: 10)
      within "li##{@reward.name.downcase.split(" ").join}" do
        expect(page).to_not have_link "Edit", href: edit_admin_reward_path(@reward)
        expect(page).to_not have_link "Delete", href: admin_reward_path(@reward)
        expect(page).to have_link @reward.name, href: admin_reward_path(@reward)
        expect(page).to have_link "Buy", href: "/buy/#{@reward.id}"
      end
    end

    scenario "they cannot visit the admin index" do
      visit admin_rewards_path
      expect(page).to have_content "The page you were looking for doesn't exist."
    end
  end
end
  