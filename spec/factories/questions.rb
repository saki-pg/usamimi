FactoryBot.define do
  factory :question do
    title { "Question title" }
    body { "Question body" }
    association :user
    # userという名前のassociationがあると、FactoryBotはその名前のfactoryを探し、そのfactoryを使用して新しいUserオブジェクトを生成します。このUserオブジェクトは、新しく作成されるQuestionオブジェクトに関連付けられます。
  end
end
