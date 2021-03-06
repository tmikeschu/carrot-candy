require 'rails_helper'

RSpec.feature "User creates a reward" do
  before do
    @reward = create(:reward)
    @admin  = create(:user, role: 1)
    @user   = create(:user)
    visit login_path
  end
    
  describe "as an admin" do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      allow_any_instance_of(ApplicationController).to receive(:current_admin?).and_return(true)
      visit user_path(@admin)
    end
      
    scenario "they create a reward" do
      click_on "Add Reward"
      fill_in "reward_name", with: "iPod"  
      fill_in "reward_quantity", with: 5
      fill_in "reward_point_value", with: 20
      click_on "Add Reward"
      @reward = Reward.first
      expect(current_path).to eq admin_rewards_path
      expect(page).to have_link @reward.name, href: admin_reward_path(@reward)    
    end

    context "when they forget information" do
      scenario "they receive an error" do
        click_on "Add Reward"
        fill_in "reward_name", with: ""  
        fill_in "reward_quantity", with: nil 
        fill_in "reward_point_value", with: nil 
        click_on "Add Reward"
        expect(page).to have_content "Whoops!"
        expect(page).to have_content "Name can't be blank" 
        expect(page).to have_content "Quantity can't be blank" 
        expect(page).to have_content "Point value can't be blank" 
      end
    end

    context "when they enter a duplicate name" do
      scenario "they recevie an error" do
        click_on "Add Reward"
        fill_in "reward_name", with: @reward.name  
        fill_in "reward_quantity", with: 10
        fill_in "reward_point_value", with: 15 
        click_on "Add Reward"
        expect(page).to have_content "Whoops!"
        expect(page).to have_content "Name has already been taken"
      end
    end
  end

  describe "as a user" do
    before do
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      within "form" do
        click_on "Log in"
      end
    end

    context "when the user is not an admin" do
      scenario "they cannot see an add reward link" do
        click_on "Log out"
        fill_in "email", with: @user.email
        fill_in "password", with: @user.password
        within "form" do
          click_on "Log in"
        end
        expect(page).to_not have_link "Add Reward", href: new_admin_reward_path
      end

      scenario "and they cannot use the create reward path" do
        click_on "Log out"
        fill_in "email", with: @user.email
        fill_in "password", with: @user.password
        within "form" do
          click_on "Log in"
        end
        visit new_admin_reward_path
        expect(page).to have_content "The page you were looking for doesn't exist."
      end
    end
  end
end