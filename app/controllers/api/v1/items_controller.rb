module Api
  module V1
    class ItemsController < Api::ApiController
      include ApplicationHelper

      before_action :retrieve_list
      before_action :retrieve_item, except: [:create, :index]
      before_action :retrieve_all_items, only: [:index]

      def create
        item = @list.items.build(item_params)
        render_json(item, 201, item.save)
      end

      def index
        render_get_json(@items, :ok)
      end

      def show
        render_get_json(@item, :ok)
      end

      def update
        render_json(@item, 200, @item.update(item_params))
      end

      def destroy
        render_json(@item, 204, @item.destroy)
      end

      private

      def item_params
        params.permit(:name, :done, :list_id)
      end

      def retrieve_item
        @item = @list.items.find_by(id: params[:item_id])
        return if @item
        render(json: { error: resource_not_exist_message }, status: 422)
      end

      def retrieve_all_items
        return page_limit_error unless Search.valid_page_limit?(params[:limit])
        user_resource = Item.search_by_name(params[:q])
        @items = Search.paginate(user_resource, params[:page], params[:limit])
      end
    end
  end
end
