module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: doorkeeper_token.resource_owner_id)
  end

  def signed_in?
    current_user.present?
  end
end
