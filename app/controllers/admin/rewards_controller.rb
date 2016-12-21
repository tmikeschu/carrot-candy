class Admin::RewardsController < Admin::BaseController
  before_action :require_admin
  before_action :set_reward, only: [:edit, :update, :show, :destroy]
  
  def new
    @reward = Reward.new
  end

  def create
    @reward = Reward.new(reward_params)
    if @reward.save
      flash[:success] = "#{@reward.name} added!"
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

  def show
  end

  def edit
  end

  def update
    if @reward.update(reward_params)
      flash[:success] = "Update successful!"
      redirect_to admin_rewards_path
    else
      flash[:error] = "Whoops!"
      @errors = @reward.errors.full_messages
      render :edit
    end
  end

  def destroy
    @reward.destroy
    redirect_to admin_rewards_path
  end

  private 
  def reward_params
    params.require(:reward).permit(:name, :quantity, :point_value)
  end

  def set_reward
    @reward = Reward.find(params[:id])
  end
end