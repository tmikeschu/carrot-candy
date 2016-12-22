=begin 
As an admin
when I visit the users index page
and click a user
and fill in a point value to add
and click Add Points
then I return to the index
and their point value is updated
=end

require 'rails_helper'

RSpec.feature "User assigns points to user" do
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

    scenario "they assign points to a default user" do
    end
  end

  describe "as a user" do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      allow_any_instance_of(ApplicationController).to receive(:current_admin?).and_return(false)
    end

    scenario "they cannot assign points to a user" do
    end
  end
end