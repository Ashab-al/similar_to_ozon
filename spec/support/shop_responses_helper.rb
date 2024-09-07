module Helpers
  module Responses
    module Shops
      def shop_external_response(shop)
        return nil unless shop

        {
          id: shop.id,
          name: shop.name,
          description: shop.description,
          user_id: shop.user_id,
          created_at: shop.created_at.to_s,
          updated_at: shop.updated_at.to_s
        }.as_json

      end

      def shops_external_response(shops)
        shops.map { |shop| shop_external_response(shop) }
      end
    end
  end
end
