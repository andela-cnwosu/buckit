module Api
  class ApiController < ActionController::API
    before_action :doorkeeper_authorize!

    def route_not_found
      render json: { error: "Route does not exist" }, status: 404
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
  end
end
