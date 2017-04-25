class ApiProspect
  include Virtus.model

  attribute :name, String
  attribute :description, String
  attribute :uid, Integer
  attribute :target, Boolean
end
