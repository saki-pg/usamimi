FactoryBot.define do
  factory :answer do
    body { "Answer body" }
    question
    user
    # 他の属性もここに定義します。
  end
end
