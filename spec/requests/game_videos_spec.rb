# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GameVideos' do
  describe 'non registered user management' do
    it 'cannot GET new and redirects to the sign_in page' do
      get new_game_video_path
      expect(response).to redirect_to(new_press_service_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end
  end

  describe 'press_service management' do
    before do
      press_service = create(:press_service)
      login_as(press_service, scope: :press_service)
    end

    it 'can GET new with params game_id' do
      game = create(:game)
      get new_game_video_path(game_id: game.id)
      expect(response).to be_successful
    end

    it 'can GET new with params video_id' do
      video = create(:video)
      get new_game_video_path(video_id: video.id)
      expect(response).to be_successful
    end

    it 'cannot GET new without params' do
      get new_game_video_path
      expect(response).to redirect_to(videos_url)
    end

    it 'can POST create' do
      game = create(:game)
      video = create(:video)
      post game_videos_path,
           params: { game_video: attributes_for(:game_video, game_id: game.id, video_id: video.id) }
      expect(flash[:notice]).to include(I18n.t('notice.create.game_video'))
    end

    it 'can DELETE destroy' do
      game = create(:game)
      game_video = create(:game_video, game_id: game.id)
      delete game_video_path(game_video)
      expect(response).to redirect_to(game_url(game))
      expect(flash[:notice]).to include(I18n.t('notice.destroy.game_video'))
    end
  end
end
