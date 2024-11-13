# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Stadia' do
  describe 'non registered user management' do
    it 'cannot GET index and redirects to the sign_in page' do
      get stadia_path
      expect(response).to redirect_to(new_press_service_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET new and redirects to the sign_in page' do
      get new_stadium_path
      expect(response).to redirect_to(new_press_service_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET edit and redirects to the sign_in page' do
      stadium = create(:stadium)
      get edit_stadium_path(stadium)
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
      get stadia_path
      expect(response).to be_successful
    end

    it 'can GET new' do
      get new_stadium_path
      expect(response).to be_successful
    end

    it 'can POST create' do
      post stadia_path, params: { stadium: attributes_for(:stadium) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.stadium'))
    end

    it 'can GET edit stadium' do
      stadium = create(:stadium)
      get edit_stadium_path(stadium)
      expect(response).to be_successful
    end

    it 'can PUT update stadium' do
      stadium = create(:stadium, stadium_name: 'Silsky')
      put stadium_path(stadium), params: { stadium: { stadium_name: 'Home arena' } }
      expect(stadium.reload.stadium_name).to eq('Home arena')
      expect(response).to redirect_to(stadia_path)
      expect(flash[:notice]).to include(I18n.t('notice.update.stadium'))
    end
  end
end
