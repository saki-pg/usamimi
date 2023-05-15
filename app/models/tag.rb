# frozen_string_literal: true

class Tag < ApplicationRecord
  # question_tagsをたくさん持っている
  has_many :question_tags, dependent: :destroy
  # question_tagsをたくさん持っていて、question_tagsを介してquestionsをたくさん持っている
  has_many :questions, through: :question_tags
end
