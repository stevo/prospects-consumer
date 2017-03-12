require "rails_helper"
require "support/capabilities/admin/prospects"

RSpec.describe "Prospects management" do
  scenario do
    behavior "Admin sees prospects" do

    end
  end

  def admin_ux
    @admin_ux ||= AdminExperience.new.tap do |ux|
      ux.extend(Capabilities::Admin::Prospects)
    end
  end
end
