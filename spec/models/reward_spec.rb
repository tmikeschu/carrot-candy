require 'rails_helper'

RSpec.describe Reward, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_uniqueness_of(:name)}
    it {should validate_presence_of(:quantity)}
    it {should validate_presence_of(:point_value)}
  end
end