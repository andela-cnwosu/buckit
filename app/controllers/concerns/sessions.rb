module Sessions
  include ApplicationHelper

  def sign_in(user)
    session[:user_id] = user.id
    flash_and_redirect_to_root(:success, successful_login_message)
  end

  def signed_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
    flash_and_redirect_to_root(:success, successful_logout_message)
  end

  def current_user_id
    (current_user.id if current_user) || nil
  end
end
