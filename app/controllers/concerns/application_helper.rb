module ApplicationHelper
  include Messages

  def flash_and_redirect_to_root(type, message)
    flash[type] = message
    redirect_to root_url
  end

  def render_json(model, status, succeeded)
    if succeeded
      message = resource_with_message model
    else
      message = { error: model.errors.full_messages }
      status = 422
    end
    render json: message, status: status
  end

  def render_get_json(model, status)
    render json: model, status: status
  end

  def resource_with_message(model)
    model_hash = "#{model.class}Serializer".constantize.new(model)
    success_message_hash = { Message: request_success_message }
    [success_message_hash, model_hash].reduce(:merge)
  end
end
