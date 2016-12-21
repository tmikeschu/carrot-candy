class Admin::RewardsController < Admin::BaseController
  def new
    @reward = Reward.new
  end

  def create
    @reward = Reward.new(reward_params)
    if @reward.save
      flash[:succes] = "#{@reward.name} added!"
      redirect_to admin_rewards_path
    else
      flash[:error] = "Whoops!"
      @errors = @reward.errors.full_messages
      render :new
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