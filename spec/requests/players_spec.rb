# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Players' do
  describe 'non registered user management' do
    it 'can GET index' do
      get players_path
      expect(response).to be_successful
    end

    it 'can GET show' do
      player = create(:player)
      get player_path(player)
      expect(response).to be_successful
    end

    it 'cannot GET new and redirects to the sign_in page' do
      get new_player_path
      expect(response).to redirect_to(new_press_service_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET edit and redirects to the sign_in page' do
      player = create(:player)
      get edit_player_path(player)
      expect(response).to redirect_to(new_press_service_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end
  end

  describe 'press_service management' do
    before do
      @press_service = create(:press_service)
      login_as(@press_service, scope: :press_service)
    end

    it 'can GET index' do
      get players_path
      expect(response).to be_successful
    end

    it 'can GET new' do
      get new_player_path
      expect(response).to be_successful
    end

    it 'can POST create' do
      post players_path, params: { player: attributes_for(:player) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.player'))
    end

    it 'can GET show' do
      player = create(:player)
      get player_path(player)
      expect(response).to be_successful
    end

    it 'can GET edit' do
      player = create(:player)
      get edit_player_path(player)
      expect(response).to be_successful
    end

    it 'can PUT update' do
      player = create(:player, name: 'Abcd')
      put player_path(player), params: { player: { name: 'Dbca' } }
      expect(player.reload.name).to eq('Dbca')
      expect(response).to redirect_to(player_path(player))
      expect(flash[:notice]).to include(I18n.t('notice.update.player'))
    end

    it 'can DELETE destroy' do
      player = create(:player)
      delete player_path(player)
      expect(response).to redirect_to(players_url)
      expect(flash[:notice]).to include(I18n.t('notice.destroy.player'))
    end
  end
end
