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
    within "li##{@rewards.first.name.downcase.split(" ").join}" do
      expect(page).to_not have_content "iPod"
      click_on "Edit Reward"
    end
    fill_in "reward_name", with: "iPod"  
    fill_in "reward_quantity", with: 5
    fill_in "reward_point_value", with: 20
    click_on "Update Reward"
    expect(page).to have_content "Update successful!"
    expect(page).to_not have_content @rewards.first.name
    within "li#ipod" do
      expect(page).to have_content "iPod"
      expect(page).to have_content 5
      expect(page).to have_content 20
    end
  end

  context "when they submit empty information" do
    scenario "they see an error" do
      within "li##{@rewards.first.name.downcase.split(" ").join}" do
        expect(page).to_not have_content "iPod"
        click_on "Edit Reward"
      end
      fill_in "reward_name", with: ""  
      fill_in "reward_quantity", with: nil 
      fill_in "reward_point_value", with: nil 
      click_on "Update Reward"
      expect(page).to have_content "Name can't be blank"
      expect(page).to have_content "Quantity can't be blank"
      expect(page).to have_content "Point value can't be blank"
    end
  end

  context "when a user is logged in" do
    before do
      click_on "Log out"
      within "form" do
        click_on "Log in"
      end
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      within "form" do
        click_on "Log in"
      end
    end

    scenario "they cannot see an edit link on the index page" do
      visit rewards_path
      expect(page).to_not have_content "Edit Reward"
    end

    scenario "they cannot override with the url" do
      visit edit_admin_reward_path(@rewards.first)
      expect(page).to have_content "The page you were looking for doesn't exist."
    end
  end
end
