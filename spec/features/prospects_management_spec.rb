require "rails_helper"
require "support/capabilities/admin/prospects"

RSpec.describe "Prospects management" do
  scenario do
    create(:prospect, name: "Iron Man", description: "Does want suit upgrade", target: true)

    behavior "Admin sees prospects" do
      admin_ux.navigate_to_prospects

      expect(admin_ux).to have_selector("h1", text: "Prospects")
      expect(admin_ux).to have_table_row_contents("Iron Man", "Does want suit upgrade", "true", position: 1)
    end
  end

  def admin_ux
    @admin_ux ||= AdminExperience.new.tap do |ux|
      ux.extend(Capabilities::Admin::Prospects)
    end
  end
end
