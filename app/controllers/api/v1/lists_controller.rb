module Api
  module V1
    class ListsController < Api::ApiController
      include ApplicationHelper

      def create
        list = List.new(name: params[:name], created_by: current_user)
        if list.save
          render(json: list, status: 201)
        else
          respond_to do |format|
            format.js
          end
        end
      end
    end
  end
end
