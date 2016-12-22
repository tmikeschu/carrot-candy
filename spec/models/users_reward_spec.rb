require 'rails_helper'

RSpec.describe UsersReward, type: :model do
  describe "associations" do
    it {should belong_to(:user)}
    it {should belong_to(:reward)}
  end
end