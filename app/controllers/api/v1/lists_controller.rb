module Api
  module V1
    class ListsController < Api::ApiController
      include ApplicationHelper

      before_action :retrieve_list, except: [:create, :index]

      def index
        lists = current_user.lists
        return render_json(lists, 200, true) unless lists.empty?
        error = resources_not_exist_message("bucket list")
        render(json: { error: error }, status: 204)
      end

      def create
        list = current_user.lists.build(list_params)
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
    end
  end
end
