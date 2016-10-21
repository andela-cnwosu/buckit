module ApplicationHelper
  include Messages

  def flash_and_redirect_to_root(type, message)
    flash[type] = message
    redirect_to root_url
  end

  def render_json(model, status, succeeded)
    if succeeded
      message = model
    else
      message = { error: model.errors.full_messages }
      status = 422
    end
    render json: message, status: status
  end
end
