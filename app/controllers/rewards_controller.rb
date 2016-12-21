class RewardsController < ApplicationController
  def new
    @reward = Reward.new
  end

  def create
    @reward = Reward.new(reward_params)
    if @reward.save
      flash[:succes] = "#{@reward.name} added!"
      redirect_to rewards_path
    else
    end
  end

  def index
    @rewards = Reward.all
  end

  private 
  def reward_params
    params.require(:reward).permit(:name, :quantity, :point_value)
  end
end