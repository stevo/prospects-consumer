Dir[Rails.root.join("spec/support/matchers/*.rb")].each { |file| require file }

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.include Support::Matchers#, type: :feature
  # config.include Support::Matchers, type: :request
end
