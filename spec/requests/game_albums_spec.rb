# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GameAlbums' do
  describe 'non registered user management' do
    it 'cannot GET new and redirects to the sign_in page' do
      get new_game_album_path
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
      get new_game_album_path(game_id: game.id)
      expect(response).to be_successful
    end

    it 'can GET new with params album_id' do
      album = create(:album)
      get new_game_album_path(album_id: album.id)
      expect(response).to be_successful
    end

    it 'cannot GET new without params' do
      get new_game_album_path
      expect(response).to redirect_to(albums_url)
    end

    it 'can POST create' do
      game = create(:game)
      album = create(:album)
      post game_albums_path,
           params: { game_album: attributes_for(:game_album, game_id: game.id, album_id: album.id) }
      expect(flash[:notice]).to include(I18n.t('notice.create.game_album'))
    end

    it 'can DELETE destroy' do
      game = create(:game)
      game_album = create(:game_album, game_id: game.id)
      delete game_album_path(game_album)
      expect(response).to redirect_to(game_url(game))
      expect(flash[:notice]).to include(I18n.t('notice.destroy.game_album'))
    end
  end
end
