require 'rails_helper'
require 'support/capabilities/admin/dashboard'

RSpec.describe 'Prospects management' do
  scenario do
    prospect = create(:prospect, name: 'Iron Man', description: 'Does want suit upgrade', target: true)
    create(:document, title: "CV Dariusz Whylon", created_at: "2017-04-17", prospect: prospect)

    behavior 'Admin sees prospects' do
      admin_ux.navigate_to_dashboard

      expect(admin_ux).to have_selector('h1', text: 'Dashboard')
      expect(admin_ux).to have_selector('h2', text: 'Project timeline')

      expect(admin_ux).to have_date_row_content('2017-04-17', position: 1) do
        expect(admin_ux).to have_prospect('Iron Man')
        expect(admin_ux).to have_document_row_content('CV Dariusz Whylon', position: 1)
      end
    end
  end

  def admin_ux
    @admin_ux ||= AdminExperience.new.tap do |ux|
      ux.extend(Capabilities::Admin::Dashboard)
    end
  end
end
