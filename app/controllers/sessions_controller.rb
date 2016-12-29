class SessionsController < ApplicationController
  def new
    redirect_to user_path(current_user) if current_user
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success]   = "Login successful!"
      redirect_to user_path(@user)
    else
      if @user
        @errors = @user.errors.full_messages
        flash.now[:error] = "Incorrect password. Try again."
      else
        flash.now[:error] = "Unknown email. Try again."
      end
      render :new
    end
  end

  def destroy
    reset_session
    flash[:success] = "Logout successful!"
    redirect_to login_path
  end
end