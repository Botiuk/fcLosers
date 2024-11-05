# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles' do
  describe 'non registered user management' do
    it 'can GET index' do
      get articles_path
      expect(response).to be_successful
    end

    it 'can GET show' do
      article = create(:article)
      get article_path(article)
      expect(response).to be_successful
    end

    it 'cannot GET show if published_at == nil and redirects to the articles page' do
      article = create(:article, published_at: nil)
      get article_path(article)
      expect(response).to redirect_to(articles_path)
    end

    it 'cannot GET show if published_at > DateTime.now and redirects to the articles page' do
      article = create(:article, published_at: DateTime.now + 5.days)
      get article_path(article)
      expect(response).to redirect_to(articles_path)
    end

    it 'cannot GET new and redirects to the sign_in page' do
      get new_article_path
      expect(response).to redirect_to(new_press_service_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET edit and redirects to the sign_in page' do
      article = create(:article)
      get edit_article_path(article)
      expect(response).to redirect_to(new_press_service_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end
  end

  describe 'press_service management' do
    before do
      press_service = create(:press_service)
      login_as(press_service, scope: :press_service)
    end

    it 'can GET index' do
      get articles_path
      expect(response).to be_successful
    end

    it 'can GET new' do
      get new_article_path
      expect(response).to be_successful
    end

    it 'can POST create' do
      post articles_path, params: { article: attributes_for(:article) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.article'))
    end

    it 'can GET show' do
      article = create(:article)
      get article_path(article)
      expect(response).to be_successful
    end

    it 'can GET show if published_at == nil' do
      article = create(:article, published_at: nil)
      get article_path(article)
      expect(response).to be_successful
    end

    it 'can GET show if published_at > DateTime.now' do
      article = create(:article, published_at: DateTime.now + 5.days)
      get article_path(article)
      expect(response).to be_successful
    end

    it 'can GET edit' do
      article = create(:article)
      get edit_article_path(article)
      expect(response).to be_successful
    end

    it 'can PUT update' do
      article = create(:article, title: 'Abcd')
      put article_path(article), params: { article: { title: 'Dbca' } }
      expect(article.reload.title).to eq('Dbca')
      expect(response).to redirect_to(article_path(article))
      expect(flash[:notice]).to include(I18n.t('notice.update.article'))
    end

    it 'can DELETE destroy' do
      article = create(:article)
      delete article_path(article)
      expect(response).to redirect_to(articles_url)
      expect(flash[:notice]).to include(I18n.t('notice.destroy.article'))
    end
  end
end
