# frozen_string_literal: true

ActiveAdmin.register Reaction do
  permit_params :user_id, :answer_id, :body
end
