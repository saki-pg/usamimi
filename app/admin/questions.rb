# frozen_string_literal: true

ActiveAdmin.register Question do
  permit_params :user_id, :title, :body, :best_answer_id, :views_count

  filter :image_attached?, as: :boolean, label: '画像添付'

  form do |f|
    f.inputs 'Question Details' do
      f.input :title
      f.input :body
      f.input :image, as: :file
    end
    f.actions
  end

  scope :all
  scope :with_image
  scope :without_image
end
