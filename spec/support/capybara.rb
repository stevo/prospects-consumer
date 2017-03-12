require "support/prospects_consumer/session"

module Capybara
  module DSL
    remove_method :using_session
    remove_method :page

    def page
      @page ||= ::ProspectsConsumer::Session.next(driver: Capybara.current_driver)
    end
  end
end
