class Prospect < ApplicationRecord
  has_many :documents
  belongs_to :owner, foreign_key: :owner_id, class_name: User.name
end
