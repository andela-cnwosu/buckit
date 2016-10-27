module Messages
  def successful_login_message
    "You have been logged in successfully"
  end

  def successful_logout_message
    "You have been logged out successfully"
  end

  def resource_not_exist_message
    "The resource requested does not exist"
  end

  def resources_not_exist_message(resource)
    "You currently do not have any #{resource}"
  end

  def request_success_message
    "Request was processed successfully"
  end

  def paginate_limit_message(limit)
    "You can only retrieve up to #{limit} lists on a page"
  end

  def invalid_login_message
    "Your login information is incorrect"
  end
end
