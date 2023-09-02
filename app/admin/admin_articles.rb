# frozen_string_literal: true

ActiveAdmin.register AdminArticle do
  filter :admin
  filter :content
  filter :created_at

  permit_params :title, :content, :admin, :image

  form do |f|
    f.inputs do
      f.input :title
      f.input :content
      f.input :admin
      f.input :image, as: :file
    end
    f.actions
  end
end
