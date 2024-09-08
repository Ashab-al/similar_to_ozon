module Helpers
  module Responses
    module Category
      def category_external_response(category)
        return nil unless category

        {
          id: category.id,
          title: category.title,
          description: category.description,
          created_at: category.created_at.to_s,
          updated_at: category.updated_at.to_s
        }.as_json

      end

      def categories_external_response(categories)
        categories.map { |category| category_external_response(category) }
      end
    end
  end
end
