module Api
  module V1
    class ListsController < Api::ApiController
      include ApplicationHelper

      before_action :retrieve_list, except: [:create, :index]

      def index
        if valid_page_limit?
          lists = current_user.lists.paginate(params[:page], params[:limit])
          return render_get_json(lists, 200) unless lists.empty?
          error = resources_not_exist_message("bucket list")
          render(json: { error: error }, status: 204)
        end
      end

      def create
        list = current_user.lists.build(list_params)
        render_json(list, 201, list.save)
      end

      def update
        render_json(@list, 200, @list.update(list_params))
      end

      def show
        render_get_json(@list, 200)
      end

      def destroy
        render_json(@list, 204, @list.destroy)
      end

      private

      def list_params
        params.permit(:name)
      end

      def valid_page_limit?
        settings = List::SETTINGS
        valid_limit = (settings[:min_page_limit]..settings[:page_limit]).to_a
        is_valid = valid_limit.include?(params[:limit].to_i) || !params[:limit]
        error = paginate_limit_message(settings[:page_limit])
        render(json: { error: error }, status: 404) unless is_valid
        is_valid
      end
    end
  end
end
