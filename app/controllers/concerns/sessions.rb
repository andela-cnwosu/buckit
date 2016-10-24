module Sessions
  include ApplicationHelper

  def sign_in(user)
    session[:user_id] = user.id
    flash[:success] = successful_login_message
    if session[:return_route]
      redirect_to session[:return_route]
    else
      redirect_to root_url
    end
  end

  def log_out
    session.clear
    @current_user = nil
    flash_and_redirect_to_root(:success, successful_logout_message)
  end
end
