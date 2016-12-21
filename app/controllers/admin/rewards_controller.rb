class Admin::RewardsController < Admin::BaseController
  before_action :require_admin, only: [:new, :create]
  before_action :set_reward, only: [:edit, :update]
  
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

  def edit
  end

  def update
    if @reward.update(reward_params)
      flash[:success] = "Update successful!"
      redirect_to admin_rewards_path
    else
    end
  end

  private 
  def reward_params
    params.require(:reward).permit(:name, :quantity, :point_value)
  end

  def set_reward
    @reward = Reward.find(params[:id])
  end
end