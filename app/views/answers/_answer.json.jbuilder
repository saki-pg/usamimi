# frozen_string_literal: true

json.extract! answer, :id, :user_id, :question_id, :body, :created_at, :updated_at
json.url answer_url(answer, format: :json)
