class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:edit, :update, :show]
  def new
    @user = User.new 
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Account created!"
      redirect_to admin_users_path
    else
      flash.now[:error] = "Whoops!"
      @errors = @user.errors.full_messages
      render :new
    end
  end

  def index
    @users = User.where(role: "default")
  end

  def edit
  end

  def show
  end

  def update
    @user.points += point_params[:points].to_i
    @user.save
    flash[:success] = "#{point_params[:points]} points added for #{@user.name}"
    redirect_to admin_users_path
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end

    def point_params
      params.require(:user).permit(:points)
    end

    def set_user
      @user = User.find(params[:id])
    end
end