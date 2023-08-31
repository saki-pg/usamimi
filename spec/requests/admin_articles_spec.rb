require 'rails_helper'

RSpec.describe "AdminArticles", type: :request do
  describe "GET /index" do
    it "成功したレスポンスを返すこと" do
      get "/articles"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "成功したレスポンスを返すこと" do
      admin_article = create(:admin_article)
      get "/articles/#{admin_article.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
