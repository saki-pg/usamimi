class AdminArticlesController < ApplicationController
  def index
    @admin_articles = AdminArticle.where(admin: true).order(created_at: :desc)
  end

  def show
    @admin_article = AdminArticle.find(params[:id])
  end
end
