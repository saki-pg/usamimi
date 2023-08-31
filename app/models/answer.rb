# frozen_string_literal: true

# 各回答はユーザーと質問に関連づけられ、質問が削除された場合は依存関係により自動的に削除
class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :reactions, dependent: :destroy

  validates :body, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[body created_at id question_id updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[question reactions user]
  end
end
