RSpec.configure do |config|
  config.append_after(:example) do
    sessions = ProspectsConsumer::Session.pool.release
  end
end

module ProspectsConsumer
  module Session
    BLOCK_URLS = %w(
    )

    ALLOW_URLS = %w(
    )

    class << self
      def next(driver:)
        pool.next(driver).tap do |session|
          if session.driver.respond_to? :block_url
            BLOCK_URLS.each do |url|
              session.driver.block_url(url)
            end
            ALLOW_URLS.each do |url|
              session.driver.allow_url(url)
            end
          end
        end
      end

      def create(driver)
        Capybara::Session.new(driver, Capybara.app)
      end

      def pool
        @pool ||= Pool.new
      end
    end

    class Pool
      attr_accessor :idle, :taken

      def initialize
        @idle   = []
        @taken  = []
      end

      def next(driver)
        take_idle(driver) || create(driver)
      end

      def release
        free_items = taken.select do |item|
          begin
            item.reset!
            true
          rescue Errno::EPIPE, EOFError
            puts "webkit connection failed"
            false
          end
        end
        idle.concat(free_items)
        taken.clear
        free_items
      end

      private

      def take_idle(driver)
        idle.find { |s| s.mode == driver }.tap do |session|
          if session
            idle.delete(session)
            taken.push(session)
          end
        end
      end

      def create(driver)
        ProspectsConsumer::Session.create(driver).tap do |session|
          taken.push(session)
        end
      end
    end
  end
end
