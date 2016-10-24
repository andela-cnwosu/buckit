module Sessions
  include ApplicationHelper

  def sign_in(user)
    session[:user_id] = user.id
    flash_and_redirect_to_root(:success, successful_login_message)
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
    flash_and_redirect_to_root(:success, successful_logout_message)
  end
end
