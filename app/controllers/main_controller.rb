# frozen_string_literal: true

class MainController < ApplicationController
  def index
    @articles = Article.where.not(published_at: nil).where.not('published_at > ?',
                                                               DateTime.now).articles_ordered.first(5)
  end
end
