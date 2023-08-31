# frozen_string_literal: true

class QuestionTag < ApplicationRecord
  belongs_to :tag
  belongs_to :question

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id question_id tag_id updated_at]
  end
end
