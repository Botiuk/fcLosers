# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Albums' do
  describe 'non registered user management' do
    it 'can GET index' do
      get albums_path
      expect(response).to be_successful
    end

    it 'can GET show' do
      album = create(:album)
      get album_path(album)
      expect(response).to be_successful
    end

    it 'cannot GET new and redirects to the sign_in page' do
      get new_album_path
      expect(response).to redirect_to(new_press_service_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET edit and redirects to the sign_in page' do
      album = create(:album)
      get edit_album_path(album)
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
      get albums_path
      expect(response).to be_successful
    end

    it 'can GET new' do
      get new_album_path
      expect(response).to be_successful
    end

    it 'can POST create' do
      post albums_path, params: { album: attributes_for(:album) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.album'))
    end

    it 'can GET show' do
      album = create(:album)
      get album_path(album)
      expect(response).to be_successful
    end

    it 'can GET edit' do
      album = create(:album)
      get edit_album_path(album)
      expect(response).to be_successful
    end

    it 'can PUT update' do
      album = create(:album, name: 'Photo')
      put album_path(album), params: { album: { name: 'Other photo' } }
      expect(album.reload.name).to eq('Other photo')
      expect(response).to redirect_to(album_path(album))
      expect(flash[:notice]).to include(I18n.t('notice.update.album'))
    end

    it 'can DELETE destroy' do
      album = create(:album)
      delete album_path(album)
      expect(response).to redirect_to(albums_url)
      expect(flash[:notice]).to include(I18n.t('notice.destroy.album'))
    end
  end
end
