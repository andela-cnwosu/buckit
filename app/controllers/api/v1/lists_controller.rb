module Api
  module V1
    class ListsController < Api::ApiController
      include ApplicationHelper

      before_action :retrieve_list, except: [:create, :index]
      before_action :retrieve_all_lists, only: [:index]

      def index

        return render_get_json(@lists, :ok) unless @lists.empty?
        error = resources_not_exist_message("bucket list")
        render(json: { error: error }, status: :no_content)
      end

      def create
        list = current_user.lists.build(list_params)
        render_json(list, :created, list.save)
      end

      def update
        render_json(@list, :no_content, @list.update(list_params))
      end

      def show
        render_get_json(@list, :ok)
      end

      def destroy
        render_json(@list, :no_content, @list.destroy)
      end

      private

      def list_params
        params.permit(:name)
      end

      def retrieve_all_lists
        if params[:q]
          @lists = current_user.lists.search_by_name(params[:q])
        else
          return page_limit_error unless List.valid_page_limit?(params[:limit])
          @lists = current_user.lists.paginate(params[:page], params[:limit])
        end
      end

      def page_limit_error
        error = paginate_limit_message(List::SETTINGS[:page_limit])
        render(json: { error: error }, status: 404)
      end
    end
  end
end
