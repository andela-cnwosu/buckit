class UsersController < ApplicationController
  include Messages
  include ApplicationHelper

  def new

  end

  def create
    user = User.new(user_params)
    if user.save
      flash_and_redirect_to_root(:success, successful_signup_message)
    else
      flash_and_redirect_to_root(:error, user.errors.full_messages)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
