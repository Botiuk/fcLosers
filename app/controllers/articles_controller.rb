# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :authenticate_press_service!, except: %i[index show]
  before_action :set_article, only: %i[edit update show destroy]

  def index
    if press_service_signed_in?
      @pagy, @articles = pagy(Article.order(published_at: :desc), limit: 9)
    else
      @pagy, @articles = pagy(
        Article.where.not(published_at: nil).where.not('published_at > ?',
                                                       DateTime.now).order(published_at: :desc), limit: 9
      )
    end
  rescue Pagy::OverflowError
    redirect_to articles_url(page: 1)
  end

  def show
    return if press_service_signed_in?
    return unless @article.published_at.nil? || @article.published_at > DateTime.now

    redirect_to articles_url
  end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_url(@article), notice: t('notice.create.article')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      redirect_to article_url(@article), notice: t('notice.update.article')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url, notice: t('notice.destroy.article')
  end

  private

  def set_article
    @article = Article.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to articles_url
  end

  def article_params
    params.require(:article).permit(:title, :article_type, :published_at, :cover, :content)
  end
end
