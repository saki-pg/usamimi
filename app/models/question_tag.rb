# frozen_string_literal: true

class QuestionTag < ApplicationRecord
  belongs_to :tag
  belongs_to :question
end
