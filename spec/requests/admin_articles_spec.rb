require 'rails_helper'

RSpec.describe "AdminArticles", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin_articles/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admin_articles/show"
      expect(response).to have_http_status(:success)
    end
  end

end
