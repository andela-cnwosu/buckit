module MessagesHelper
  def successful_logout_message
    "You have been logged out successfully"
  end

  def successful_login_message
    "You have been logged in successfully"
  end

  def resource_not_exist_message
    "The resource requested does not exist"
  end

  def route_not_exist_message
    "Route does not exist"
  end

  def invalid_login_message
    "Your login information is incorrect"
  end

  def paginate_limit_error
    "You can only retrieve up to 100 lists on a page"
  end
end
