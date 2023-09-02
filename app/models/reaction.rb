# frozen_string_literal: true

# ユーザーと回答に対する関連付けを持ち、具体的な反応内容を`body`属性で管理
class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :answer

  validates :body, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[answer_id body created_at id updated_at user_id]
  end
end
