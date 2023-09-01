require 'rails_helper'

RSpec.describe "AdminArticles", type: :request do
  let(:article) { create(:admin_article) }

  describe "GET /index" do
    it "成功したレスポンスを返すこと" do
      get admin_articles_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /show" do
    it "HTTPステータスが成功を返すこと" do
      get admin_article_path(article)
      expect(response).to have_http_status(200)
    end
  end
end
