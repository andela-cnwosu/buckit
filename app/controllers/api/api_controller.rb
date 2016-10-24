module Api
  class ApiController < ActionController::API
    include SessionsHelper

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
      unless @list
        render(json: { error: resource_not_exist_message }, status: 422)
        return
      end
    end
  end
end
