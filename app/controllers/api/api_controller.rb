module Api
  class ApiController < ActionController::API
    include Messages

    before_action :doorkeeper_authorize!

    def endpoint_not_found
      render json: { error: "Endpoint does not exist" }, status: :not_found
    end

    def doorkeeper_unauthorized_render_options(*)
      { json: { error: "Access token is required" } }
    end

    def retrieve_list
      list_id = params[:id] || params[:list_id]
      @list = current_user.lists.find_by(id: list_id)
      return if @list
      render(json: { error: resource_not_exist_message }, status: 422)
    end

    def current_user
      User.find_by(id: doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    def render_json(model, status, succeeded)
      if succeeded
        message = model
      else
        message = { error: model.errors.full_messages }
        status = :unprocessable_entity
      end
      render json: message, status: status
    end

    def render_get_json(model, status)
      return render(json: model, status: status) if model.present?
      error = resource_not_exist_message
      render(json: { error: error }, status: :not_found)
    end

    def page_limit_error
      set = Search::SETTINGS
      error = paginate_limit_message(set[:min_page_limit], set[:page_limit])
      render(json: { error: error }, status: :not_found)
    end
  end
end
