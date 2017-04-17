FactoryGirl.define do
  factory :document do
    sequence(:title) { |n| "Document ##{n}"}
    sequence(:body) { |n| "Document ##{n} body"}
    creator { create(:user) }
    prospect { create(:prospect) }

    trait :cv do
      document_type "cv"
    end

    trait :team_presentation do
      document_type "team_presentation"
    end

    trait :project_overview do
      document_type "project_overview"
    end

    trait :estimation do
      document_type "estimation"
    end
  end
end
