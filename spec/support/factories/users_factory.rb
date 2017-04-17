FactoryGirl.define do
  factory :user do
    first_name "Tony"
    last_name "Stark"
    sequence(:email) { |n| "user_#{n}@prospects.dev" }
    admin false

    trait :admin do
      admin true
    end
  end
end
