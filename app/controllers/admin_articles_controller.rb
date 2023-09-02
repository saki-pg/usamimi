# frozen_string_literal: true

class AdminArticlesController < ApplicationController
  def index
    @admin_articles = AdminArticle.order(created_at: :desc).limit(50)
  end

  def show
    @admin_article = AdminArticle.find(params[:id])
  end
end
