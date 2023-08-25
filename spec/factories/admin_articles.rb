FactoryBot.define do
  factory :admin_article do
    title { "MyString" }
    content { "MyText" }
    admin { false }
  end
end
