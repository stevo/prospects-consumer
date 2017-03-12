require "support/feature_helpers"
require "support/prospects_consumer/session"

class Experience
  include Capybara::DSL
  include FactoryGirl::Syntax::Methods
  include FeatureHelpers
  include Rails.application.routes.url_helpers

  delegate :t, to: I18n

  def reload_page
    visit current_url
  end

  def driver
    @driver ||= Capybara.current_driver
  end

  def page
    @page ||= OpsApp::Session.next(driver: driver)
  end
end

Dir[Rails.root.join("spec/support/experiences/**/*.rb")].each { |file| require file }
