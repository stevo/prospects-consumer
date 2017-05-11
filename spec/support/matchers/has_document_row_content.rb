module Support
  module Matchers
    def have_document_row_content(*text, position: nil)
      HasDocumentRowContent.new(*text, position: position)
    end

    class HasDocumentRowContent
      def initialize(*text, position: nil)
        @position = position
        @text = text
      end

      def matches?(page)
        @page = page
        result = false

        if block_given?
          page.within(scoped_page) do
            result = yield
          end
        else
          result = has_matching_row?
        end

        result
      end

      def description
        "have row with #{contents}"
      end

      def failure_message
        "Expected page to have row with #{contents}, but it did not"
      end

      def failure_message_when_negated
        "Expected page not to have row with #{contents}, but it did"
      end

      def contents
        text.map { |t| "'#{t}'" }.join(', ')
      end

      private

      attr_reader :page, :text, :position

      def row_matcher
        if position.nil?
          'ol li'
        else
          "ol li:nth-child(#{position})"
        end
      end

      def has_matching_row?
        scoped_page
      end

      def scoped_page
        page.find(row_matcher, text: /#{text.join(".*")}/)
      end
    end
  end
end
