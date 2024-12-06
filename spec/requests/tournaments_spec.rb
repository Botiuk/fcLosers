# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tournaments' do
  describe 'non registered user management' do
    it 'cannot GET index and redirects to the sign_in page' do
      get tournaments_path
      expect(response).to redirect_to(new_press_service_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET new and redirects to the sign_in page' do
      get new_tournament_path
      expect(response).to redirect_to(new_press_service_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET edit and redirects to the sign_in page' do
      tournament = create(:tournament)
      get edit_tournament_path(tournament)
      expect(response).to redirect_to(new_press_service_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET show' do
      tournament = create(:tournament)
      get tournament_path(tournament)
      expect(response).to redirect_to(new_press_service_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'can GET cup if cup present' do
      create(:tournament, schema_type: 'national_cup')
      get cup_path
      expect(response).to be_successful
    end

    it 'can GET championship if championship present' do
      create(:tournament, schema_type: 'national_champ')
      get championship_path
      expect(response).to be_successful
    end

    it 'can GET cup if cup absent' do
      get cup_path
      expect(response).to redirect_to(root_path)
    end

    it 'can GET championship if championship absent' do
      get championship_path
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'press_service management' do
    before do
      press_service = create(:press_service)
      login_as(press_service, scope: :press_service)
    end

    it 'can GET index' do
      get tournaments_path
      expect(response).to be_successful
    end

    it 'can GET new' do
      get new_tournament_path
      expect(response).to be_successful
    end

    it 'can POST create' do
      post tournaments_path, params: { tournament: attributes_for(:tournament) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.tournament'))
    end

    it 'can GET edit tournament' do
      tournament = create(:tournament)
      get edit_tournament_path(tournament)
      expect(response).to be_successful
    end

    it 'can PUT update tournament' do
      tournament = create(:tournament, name: 'Champions League')
      put tournament_path(tournament), params: { tournament: { name: 'World cup' } }
      expect(tournament.reload.name).to eq('World cup')
      expect(response).to redirect_to(tournament)
      expect(flash[:notice]).to include(I18n.t('notice.update.tournament'))
    end

    it 'can GET show' do
      tournament = create(:tournament)
      get tournament_path(tournament)
      expect(response).to be_successful
    end

    it 'can GET cup if cup present' do
      create(:tournament, schema_type: 'national_cup')
      get cup_path
      expect(response).to be_successful
    end

    it 'can GET championship if championship present' do
      create(:tournament, schema_type: 'national_champ')
      get championship_path
      expect(response).to be_successful
    end

    it 'can GET cup if cup absent' do
      get cup_path
      expect(response).to redirect_to(root_path)
    end

    it 'can GET championship if championship absent' do
      get championship_path
      expect(response).to redirect_to(root_path)
    end
  end
end
