# frozen_string_literal: true

# 質問はユーザーに属し、複数の回答を持ち、複数のタグを持つ
class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags
  has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true
  validates :views_count, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    ['best_answer_id', 'body', 'created_at', 'id', 'title', 'updated_at', 'user_id', 'views_count', 'image_attached?']
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[answers question_tags tags user]
  end

  delegate :attached?, to: :image, prefix: true

  scope :with_image, -> { joins(:image_attachment) }
  scope :without_image, -> { left_outer_joins(:image_attachment).where(active_storage_attachments: { id: nil }) }
end
