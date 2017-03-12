module FeatureHelpers
  def wait_for_ajax
    wait_for(
      clause: "$.active == 0",
      timeout_message: "AJAX request took longer than #{Capybara.default_max_wait_time} seconds OR there was a JS error. Check your console."
    )
  end

  private

  def wait_for(clause:, timeout_message:)
    begin
      Timeout::timeout(Capybara.default_max_wait_time) do
        until evaluate_script(clause)
          sleep(0.1)
        end
      end
    rescue Timeout::Error
      raise Timeout::Error, timeout_message
    end
  end
end

RSpec.configure do |config|
  config.include FeatureHelpers, type: :feature
end
