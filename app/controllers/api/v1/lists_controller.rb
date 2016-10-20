module Api
  module V1
    class ListsController < Api::ApiController
      include ApplicationHelper

      def create
        list = List.new(list_params)
        list.user = current_user
        if list.save
          render(json: list, status: 201)
        else
          render(json: {
            error: list.errors.full_messages, status: :internal_server_error
          })
        end
      end

      def update
        list = List.find_by(id: params[:id])
        if list.update(list_params)
          render(json: list, status: 200)
        else
          render(json: {
            error: list.errors.full_messages, status: :internal_server_error
          })
        end
      end

      private

      def list_params
        params.require(:list).permit(:name)
      end
    end
  end
end
