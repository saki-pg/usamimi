# frozen_string_literal: true

class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :answer

  validates :body, presence: true
end
