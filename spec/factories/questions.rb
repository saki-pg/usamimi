FactoryBot.define do
  factory :question do
    title { "Question title" }
    body { "Question body" }
    association :user
  end
end
