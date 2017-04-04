class Prospect < ApplicationRecord
  validates :description, :name, :uid, presence: true
  validates :uid, uniqueness: true
end
