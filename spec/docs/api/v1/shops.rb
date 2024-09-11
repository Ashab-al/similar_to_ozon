require 'forwardable'

module Docs
  module Api
    module V1
      module Shops
        extend Dox::DSL::Syntax

        # define common resource data for each action
        document :api do
          resource 'Shops' do
            group 'Shops'
          end
        end

        # define data for specific action
        document :index do
          action 'passing the asc_or_desc parameter (http status answer)' do
            desc "передача параметра asc_or_desc"
          end
        end
      end
    end
  end
end
  