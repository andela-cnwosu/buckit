module Api
  module V1
    class ItemsController < Api::ApiController
      include ApplicationHelper

      before_action :retrieve_list
      before_action :retrieve_item, except: :create

      def create
        item = @list.items.build(item_params)
        render_json(item, 201, item.save)
      end

      def update
        render_json(@item, 200, @item.update(item_params))
      end

      private

      def item_params
        params.require(:item).permit(:name, :done, :list_id)
      end

      def retrieve_item
        @item = @list.items.find_by(id: params[:item_id])
        unless @item
          render(json: { error: resource_not_exist_message }, status: 422)
          return
        end
      end
    end
  end
end

