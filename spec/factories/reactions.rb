FactoryBot.define do
  factory :reaction do
    user
    answer
    body { 'This is a reaction.' }
  end
end
