class UsersController < ApplicationController
  before_action :require_login
  before_action :verify_user, only: [:show]

  def new
    @user = User.new 
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Account created!"
      redirect_to user_path(@user)
    else
      flash.now[:error] = "Whoops!"
      @errors = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def buy
    @reward = Reward.find(params[:id])
    if @reward.point_value > current_user.points
      flash[:error] = "Whoops! You do not have enough points for that reward."
      redirect_to rewards_path
    else
    end
  end

  def add_reward
    @reward = Reward.find(params[:id])
    current_user.rewards << @reward
    @reward.quantity - 1
    @reward.save
    current_user.points -= @reward.point_value
    current_user.redeemed_points += @reward.point_value
    current_user.save 
    redirect_to user_path(current_user)
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end

    def require_login
      render file: 'public/404' unless current_user
    end
    
    def verify_user
      render file: 'public/404' unless current_user.id == params[:id].to_i
    end
end