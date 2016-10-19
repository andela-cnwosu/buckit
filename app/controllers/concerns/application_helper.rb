module ApplicationHelper
  def flash_and_redirect_to_root(type, message)
    flash[type] = message
    redirect_to root_url
  end
end