class Admin::UsersController < Admin::BaseController
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

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end