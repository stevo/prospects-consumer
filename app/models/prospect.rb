class Prospect < ApplicationRecord
  has_many :documents
  belongs_to :user, foreign_key: :owner_id
end
