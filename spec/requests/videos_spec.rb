# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Videos' do
  describe 'non registered user management' do
    it 'can GET index' do
      get videos_path
      expect(response).to be_successful
    end

    it 'cannot GET new and redirects to the sign_in page' do
      get new_video_path
      expect(response).to redirect_to(new_press_service_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET edit and redirects to the sign_in page' do
      video = create(:video)
      get edit_video_path(video)
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
      get videos_path
      expect(response).to be_successful
    end

    it 'can GET new' do
      get new_video_path
      expect(response).to be_successful
    end

    it 'can POST create' do
      post videos_path, params: { video: attributes_for(:video) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.video'))
    end

    it 'can GET edit' do
      video = create(:video)
      get edit_video_path(video)
      expect(response).to be_successful
    end

    it 'can PUT update' do
      video = create(:video, name: 'Game')
      put video_path(video), params: { video: { name: 'New players' } }
      expect(video.reload.name).to eq('New players')
      expect(response).to redirect_to(videos_url)
      expect(flash[:notice]).to include(I18n.t('notice.update.video'))
    end

    it 'can DELETE destroy' do
      video = create(:video)
      delete video_path(video)
      expect(response).to redirect_to(videos_url)
      expect(flash[:notice]).to include(I18n.t('notice.destroy.video'))
    end
  end
end
