# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :reactions, dependent: :destroy

  validates :body, presence: true
end
