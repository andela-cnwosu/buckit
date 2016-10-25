module Api
  module V1
    class ListsController < Api::ApiController
      include ApplicationHelper

      before_action :retrieve_list, except: [:create, :index]
      before_action :retrieve_all_lists, only: [:index]

      def index
        return render_get_json(@lists, 200) unless @lists.empty?
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
        render_get_json(@list, 200)
      end

      def destroy
        render_json(@list, 204, @list.destroy)
      end

      private

      def list_params
        params.permit(:name)
      end

      def retrieve_all_lists
        @lists = current_user.lists
        search_lists_by_name if params[:q]
        return unless valid_page_limit?
        @lists = @lists.paginate(params[:page], params[:limit])
      end

      def search_lists_by_name
        @lists = @lists.search_by_name(params[:q])
        error = list_not_exists_message
        render(json: { error: error }, status: 404) unless @lists.present?
      end

      def valid_page_limit?
        error = paginate_limit_message(List::SETTINGS[:page_limit])
        render(json: { error: error }, status: 404) unless valid_limit?
        valid_limit?
      end

      def valid_limit?
        settings = List::SETTINGS
        valid_limit = (settings[:min_page_limit]..settings[:page_limit]).to_a
        valid_limit.include?(params[:limit].to_i) || params[:limit].nil?
      end
    end
  end
end
