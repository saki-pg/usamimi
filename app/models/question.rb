# frozen_string_literal: true

# 質問はユーザーに属し、複数の回答を持ち、複数のタグを持つ
class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags

  validates :title, presence: true
  validates :body, presence: true
end
