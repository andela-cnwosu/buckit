module Messages
  def successful_login_message
    "You have been logged in successfully"
  end

  def successful_logout_message
    "You have been logged out successfully"
  end

  def resource_not_exist_message
    "The requested resource does not exist"
  end

  def request_success_message
    "Request was processed successfully"
  end

  def paginate_limit_message(min, max)
    "You can only retrieve #{min} to #{max} lists on a page"
  end

  def invalid_login_message
    "Your login information is incorrect"
  end
end
