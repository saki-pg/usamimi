# frozen_string_literal: true

# 各回答はユーザーと質問に関連づけられ、質問が削除された場合は依存関係により自動的に削除
class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :reactions, dependent: :destroy

  validates :body, presence: true
end
