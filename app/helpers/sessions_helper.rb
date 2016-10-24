module SessionsHelper
  def current_user
    token = doorkeeper_token
    @current_user ||= User.find_by(id: token.resource_owner_id) if token
  end

  def signed_in?
    current_user.present?
  end
end
