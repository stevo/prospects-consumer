class Prospect < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :target, inclusion: {in: [true, false]}
  validates :uid, presence: true, uniqueness: true
end
