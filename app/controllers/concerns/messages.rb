module Messages
  def successful_login_message
    "You have been logged in successfully"
  end

  def successful_logout_message
    "You have been logged out successfully"
  end

  def successful_signup_message
    "You have signed up successfully"
  end

  def resource_not_exist_message
    "The resource requested does not exist"
  end

  def resources_not_exist_message(resource)
    "You currently do not have any #{resource}"
  end
end