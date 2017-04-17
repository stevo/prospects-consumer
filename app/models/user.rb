class User < ApplicationRecord
  has_many :documents, foreign_key: :creator_id
  has_many :prospects, foreign_key: :owner_id
end
