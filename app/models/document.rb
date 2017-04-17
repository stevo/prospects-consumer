class Document < ApplicationRecord
  belongs_to :creator, class_name: User.name
  belongs_to :prospect

  enum document_type: %i(cv team_presentation project_overview estimation)
end
