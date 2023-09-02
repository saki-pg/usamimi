FactoryBot.define do
  factory :answer do
    body { "Answer body" }
    question
    user
  end
end
