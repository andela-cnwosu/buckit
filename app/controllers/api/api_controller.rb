module Api
  class ApiController < ActionController::API
    include SessionsHelper

    before_action :doorkeeper_authorize!
  end
end
