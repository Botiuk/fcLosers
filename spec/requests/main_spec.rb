# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mains' do
  describe 'non registered user management' do
    it 'can GET index' do
      get root_path
      expect(response).to be_successful
    end

    it 'can GET our_team' do
      get our_team_path
      expect(response).to be_successful
    end
  end

  describe 'press_service management' do
    before do
      press_service = create(:press_service)
      login_as(press_service, scope: :press_service)
    end

    it 'can GET index' do
      get root_path
      expect(response).to be_successful
    end

    it 'can GET our_team' do
      get our_team_path
      expect(response).to be_successful
    end
  end
end
