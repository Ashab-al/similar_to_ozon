module Docs
  module Api
    module V2
      module Shops
        extend Dox::DSL::Syntax
        document :api do
          resource 'Shops' do
            group 'Shops'
          end
        end

        document :index do
          action 'passing the asc_or_desc parameter (http status answer)' do
            desc "передача параметра asc_or_desc"
          end
        end
      end
    end
  end
end
  