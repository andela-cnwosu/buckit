module Api
  module V1
    class ListsController < Api::ApiController
      include ApplicationHelper

      before_action :retrieve_list, except: [:create, :index]
      before_action :retrieve_all_lists, only: [:index]

      def index
        render_get_json(@lists, :ok)
      end

      def create
        list = current_user.lists.build(list_params)
        render_json(list, :created, list.save)
      end

      def update
        render_json(@list, :ok, @list.update(list_params))
      end

      def show
        render_get_json(@list, :ok)
      end

      def destroy
        render_json(@list, :ok, @list.destroy)
      end

      private

      def list_params
        params.permit(:name)
      end

      def retrieve_all_lists
        return page_limit_error unless Search.valid_page_limit?(params[:limit])
        user_resource = List.search_by_name(params[:q])
        @lists = Search.paginate(user_resource, params[:page], params[:limit])
      end
    end
  end
end
