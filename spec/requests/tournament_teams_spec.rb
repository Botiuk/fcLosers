# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TournamentTeams' do
  describe 'non registered user management' do
    it 'cannot GET new and redirects to the sign_in page' do
      get new_tournament_team_path
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
      get new_tournament_team_path(tournament_id: tournament.id)
      expect(response).to be_successful
    end

    it 'cannot GET new without params tournament_id' do
      get new_tournament_team_path
      expect(response).to redirect_to(tournaments_url)
    end

    it 'can POST create' do
      tournament = create(:tournament)
      team = create(:team)
      post tournament_teams_path,
           params: { tournament_team: attributes_for(:tournament_team, tournament_id: tournament.id, team_id: team.id) }
      expect(flash[:notice]).to include(I18n.t('notice.create.tournament_team'))
    end

    it 'can DELETE destroy' do
      tournament = create(:tournament)
      tournament_team = create(:tournament_team, tournament_id: tournament.id)
      delete tournament_team_path(tournament_team)
      expect(response).to redirect_to(tournament_url(tournament))
      expect(flash[:notice]).to include(I18n.t('notice.destroy.tournament_team'))
    end
  end
end
