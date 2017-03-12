FactoryGirl.define do
  factory :prospect do
    sequence(:name) { |i| "Prospect ##{i}"}
    sequence(:uid) { |i| i.to_s }
    description "Prospect description"
    target false
  end
end
