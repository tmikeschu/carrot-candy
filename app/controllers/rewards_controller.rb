class RewardsController < ApplicationController
  def index
    @rewards = Reward.all
    render "admin/rewards/index"
  end
end