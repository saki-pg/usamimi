# frozen_string_literal: true

class AdminArticle < ApplicationRecord
  has_one_attached :image

  def self.ransackable_attributes(_auth_object = nil)
    %w[admin content created_at id title updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
