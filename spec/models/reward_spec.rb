require 'rails_helper'

RSpec.describe Reward, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_uniqueness_of(:name)}
    it {should validate_presence_of(:quantity)}
    it {should validate_presence_of(:point_value)}
  end

  describe "defaults" do
    before do
      @user = User.create(first_name: "Mike", last_name: "Schutte", email: "t@mike.schutte", password: "password123")
    end
    it "users should default to default role" do
      expect(@user.role).to eq "default"
    end

    it "users should have a default point value of zero" do
      expect(@user.points).to eq 0
    end

    it "users should have a default redeemed_points value of zero" do
      expect(@user.redeemed_points).to eq 0
    end
  end

  describe "associations" do
    it {should have_many(:users_rewards)}
    it {should have_many(:users).through(:users_rewards)}
  end
end