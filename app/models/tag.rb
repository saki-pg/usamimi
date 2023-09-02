# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :question_tags, dependent: :destroy
  has_many :questions, through: :question_tags

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id name updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[question_tags questions]
  end
end
