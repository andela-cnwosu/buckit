module Api
  module V1
    class ListsController < Api::ApiController
      include ApplicationHelper

      def create
        user = User.find_by(id: doorkeeper_token.resource_owner_id)
        list = List.new(name: params[:name], user: user)
        if list.save
          render(json: list, status: 201)
        else
          render(json: {
            error: list.errors.full_messages, status: :internal_server_error
          })
        end
      end
    end
  end
end
