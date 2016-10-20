module Api
  module V1
    class ListsController < Api::ApiController
      include ApplicationHelper

      before_action :set_list, except: :create

      def create
        list = List.new(list_params)
        list.user = current_user
        render_json(list, 201, list.save)
      end

      def update
        render_json(@list, 200, @list.update(list_params))
      end

      def show
        render_json(@list, 200, true)
      end

      def destroy
        render_json(@list, 204, @list.destroy)
      end

      private

      def list_params
        params.require(:list).permit(:name)
      end

      def set_list
        @list = List.find_by(id: params[:id], user: current_user)
        unless @list
          render(json: { error: resource_not_exist_message}, status: 422)
          return
        end
      end
    end
  end
end
