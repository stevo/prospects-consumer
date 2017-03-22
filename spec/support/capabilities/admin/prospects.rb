module Capabilities
  module Admin
    module Prospects
      def navigate_to_prospects
        within_navigation do
          click_on "Prospects"
        end
      end

      def download_prospects
        click_on 'Import prospects'
      end
    end
  end
end
