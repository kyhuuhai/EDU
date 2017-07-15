class NewsController < ApplicationController
  before_action :load_news, only: :show
  before_action :popular_courses

  def index
    @newses = News.includes(:image).newest.page(params[:page])
      .per Settings.news.per_page
  end

  def show; end

  private

  def load_news
    @news = News.find_by id: params[:id]
    return if @news
    flash[:error] = t ".not_found"
    redirect_to news_index_path
  end
end
