# frozen_string_literal: true

ActiveAdmin.register Answer do
  permit_params :user_id, :question_id, :body
end
