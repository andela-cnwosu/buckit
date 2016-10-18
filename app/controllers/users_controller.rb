class UsersController < ApplicationController
  def new

  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:success] = "You have signed up successfully"
      redirect_to root_url
    else
      flash[:error] = user.errors.full_messages
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
