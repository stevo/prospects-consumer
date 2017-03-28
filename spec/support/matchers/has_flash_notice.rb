module Support
  module Matchers
    def have_flash_notice(text)
      HasFlashNotice.new(text)
    end

    class HasFlashNotice
      def initialize(text)
        @text = text
      end

      def matches?(page)
        @page = page

        has_matching_row?
      end

      def description
        "have flash notice with '#{text}'"
      end

      def failure_message
        "Expected page to have flash notice with '#{text}', but it did not"
      end

      def failure_message_when_negated
        "Expected page not to have flash notice with '#{text}', but it did"
      end

      private

      attr_reader :page, :text

      def has_matching_row?
        page.within('.notice') do
          page.has_content?(text)
        end
      rescue Capybara::ElementNotFound
      end
    end
  end
end
