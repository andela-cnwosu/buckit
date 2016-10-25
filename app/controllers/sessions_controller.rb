class SessionsController < ApplicationController
  include Messages
  include Sessions

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
    else
      render(json: { error: invalid_login_message })
    end
  end

  def destroy
    log_out
  end
end
