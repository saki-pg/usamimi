# frozen_string_literal: true

json.extract! question, :id, :user_id, :title, :body, :created_at, :updated_at
json.url question_url(question, format: :json)
