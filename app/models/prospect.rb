class Prospect < ApplicationRecord
  validates :description, :name, :uid, presence: true
  validates :target, inclusion: { in: [true, false] }
  validates :uid, uniqueness: true
end
