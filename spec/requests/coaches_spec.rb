# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Coaches' do
  describe 'non registered user management' do
    it 'can GET index' do
      get coaches_path
      expect(response).to be_successful
    end

    it 'can GET show' do
      coach = create(:coach)
      get coach_path(coach)
      expect(response).to be_successful
    end

    it 'cannot GET new and redirects to the sign_in page' do
      get new_coach_path
      expect(response).to redirect_to(new_press_service_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET edit and redirects to the sign_in page' do
      coach = create(:coach)
      get edit_coach_path(coach)
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
      get coaches_path
      expect(response).to be_successful
    end

    it 'can GET new' do
      get new_coach_path
      expect(response).to be_successful
    end

    it 'can POST create' do
      post coaches_path, params: { coach: attributes_for(:coach) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.coach'))
    end

    it 'can GET show' do
      coach = create(:coach)
      get coach_path(coach)
      expect(response).to be_successful
    end

    it 'can GET edit' do
      coach = create(:coach)
      get edit_coach_path(coach)
      expect(response).to be_successful
    end

    it 'can PUT update' do
      coach = create(:coach, name: 'Abcd')
      put coach_path(coach), params: { coach: { name: 'Dbca' } }
      expect(coach.reload.name).to eq('Dbca')
      expect(response).to redirect_to(coach_path(coach))
      expect(flash[:notice]).to include(I18n.t('notice.update.coach'))
    end

    it 'can DELETE destroy' do
      coach = create(:coach)
      delete coach_path(coach)
      expect(response).to redirect_to(coaches_url)
      expect(flash[:notice]).to include(I18n.t('notice.destroy.coach'))
    end
  end
end
