require "rails_helper"
require "support/capabilities/admin/prospects"

RSpec.describe "Prospects management" do
  scenario do
    create(:prospect, name: "Iron Man", description: "Does want suit upgrade", target: true, uid: 87)

    allow(ProspectApiWrapper).to receive(:get_prospects) do
      [
        ApiProspect.new(name: "Captain America",
                        description: "Needs new shield",
                        target: true,
                        uid: 88)
      ]
    end

    behavior "Admin sees prospects" do
      admin_ux.navigate_to_prospects

      expect(admin_ux).to have_selector("h1", text: "Prospects")
      expect(admin_ux).to have_table_row_contents("Iron Man", "Does want suit upgrade", "true", position: 1)
    end

    behavior 'Admin downloads prospects with "Import Prospects" button' do
      admin_ux.download_prospects

      expect(admin_ux).to have_flash_notice("1 new prospect was imported")

      expect(admin_ux).to have_table_row_contents("Captain America", "Needs new shield", "true", position: 1)
      expect(admin_ux).to have_table_row_contents("Iron Man", "Does want suit upgrade", "true", position: 2)
    end

    allow(ProspectApiWrapper).to(receive(:get_prospects)) {
      [
        ApiProspect.new(name: "Thor",
                        description: "Nordic God",
                        target: false,
                        uid: 90),
        ApiProspect.new(name: "Black Widow",
                        description: "Russian Killing Machine",
                        target: true,
                        uid: 89),
        ApiProspect.new(name: "Captain America",
                        description: "Needs new shield",
                        target: true,
                        uid: 88)
      ]
    }

    behavior 'Admin downloads more prospects with "Import Prospects" button' do
      admin_ux.download_prospects

      expect(admin_ux).to have_flash_notice("2 new prospects were imported")

      expect(admin_ux).to have_table_row_contents("Thor", "Nordic God", "false", position: 1)
      expect(admin_ux).to have_table_row_contents("Black Widow", "Russian Killing Machine", "true", position: 2)
      expect(admin_ux).to have_table_row_contents("Captain America", "Needs new shield", "true", position: 3)
      expect(admin_ux).to have_table_row_contents("Iron Man", "Does want suit upgrade", "true", position: 4)
    end
  end

  def admin_ux
    @admin_ux ||= AdminExperience.new.tap do |ux|
      ux.extend(Capabilities::Admin::Prospects)
    end
  end
end
