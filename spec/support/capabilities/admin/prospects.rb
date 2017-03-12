module Capabilities
  module Admin
    module Prospects
      def navigate_to_prospects
        within_navigation do
          click_on "Prospects"
        end
      end
    end
  end
end
