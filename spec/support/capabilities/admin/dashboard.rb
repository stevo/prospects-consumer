# frozen_string_literal: true

module Capabilities
  module Admin
    module Dashboard
      def navigate_to_dashboard
        within_navigation do
          click_on 'Dashboard'
        end
      end
    end
  end
end
