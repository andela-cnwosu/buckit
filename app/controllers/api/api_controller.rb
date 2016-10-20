module Api
  class ApiController < ActionController::API
    include SessionsHelper

    before_action :doorkeeper_authorize!

    def route_not_found
      render json: { error: "Route does not exist"}, status: 404
    end
  end
end
