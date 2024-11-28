# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Games' do
  describe 'non registered user management' do
    it 'cannot GET new and redirects to the sign_in page' do
      get new_game_path
      expect(response).to redirect_to(new_press_service_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'can GET show' do
      game = create(:game)
      get game_path(game)
      expect(response).to be_successful
    end

    it 'cannot GET edit and redirects to the sign_in page' do
      game = create(:game)
      get edit_game_path(game)
      expect(response).to redirect_to(new_press_service_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end
  end

  describe 'press_service management' do
    before do
      press_service = create(:press_service)
      login_as(press_service, scope: :press_service)
    end

    it 'can GET new with params tournament_id' do
      tournament = create(:tournament)
      get new_game_path(tournament_id: tournament.id)
      expect(response).to be_successful
    end

    it 'cannot GET new without params tournament_id' do
      get new_game_path
      expect(response).to redirect_to(tournaments_url)
    end

    it 'can POST create' do
      tournament = create(:tournament)
      home_team = create(:team)
      visitor_team = create(:team)
      stadium = create(:stadium)
      post games_path, params: { game: attributes_for(:game, tournament_id: tournament.id, home_team_id: home_team.id,
                                                             visitor_team_id: visitor_team.id, stadium_id: stadium.id) }
      expect(flash[:notice]).to include(I18n.t('notice.create.game'))
    end

    it 'can GET show' do
      game = create(:game)
      get game_path(game)
      expect(response).to be_successful
    end

    it 'can GET edit' do
      game = create(:game)
      get edit_game_path(game)
      expect(response).to be_successful
    end

    it 'can PUT update' do
      game = create(:game, game_type: 'group')
      put game_path(game), params: { game: { game_type: 'friendly' } }
      expect(game.reload.game_type).to eq('friendly')
      expect(response).to redirect_to(game_path(game))
      expect(flash[:notice]).to include(I18n.t('notice.update.game'))
    end

    it 'can DELETE destroy' do
      tournament = create(:tournament)
      game = create(:game, tournament_id: tournament.id)
      delete game_path(game)
      expect(response).to redirect_to(tournament_url(tournament))
      expect(flash[:notice]).to include(I18n.t('notice.destroy.game'))
    end
  end
end
