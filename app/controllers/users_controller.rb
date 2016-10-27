class UsersController < ApplicationController
  include Messages
  include Sessions

  def create
    user = User.new(user_params)
    if user.save
      sign_in user
    else
      render(json: { error: user.errors.full_messages })
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
