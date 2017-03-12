class AdminExperience < Experience
  def initialize
    visit root_path
  end

  def within_navigation
   within ".sidebar" do
      yield
    end
  end
end
