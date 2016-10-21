module Api
  module V1
    class ItemsController < Api::ApiController
      include ApplicationHelper

      def create
        item = Item.new(item_params)
        render_json(item, 201, item.save)
      end

      private

      def item_params
        params.require(:item).permit(:name, :done, :list_id)
      end
    end
  end
end

