# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tournament do
  describe 'validations' do
    it 'is valid with valid attributes' do
      tournament = build(:tournament)
      expect(tournament).to be_valid
    end

    it 'is not valid without a name' do
      tournament = build(:tournament, name: nil)
      expect(tournament).not_to be_valid
    end

    it 'is not valid without a start_date' do
      tournament = build(:tournament, start_date: nil)
      expect(tournament).not_to be_valid
    end

    it 'is valid without a end_date' do
      tournament = build(:tournament, end_date: nil)
      expect(tournament).to be_valid
    end

    it 'is not valid when start_date greater than end_date' do
      date_now = Time.zone.today
      tournament = build(:tournament, start_date: date_now, end_date: (date_now - 1.day))
      expect(tournament).not_to be_valid
    end

    it 'is valid when end_date equal start_date' do
      date_now = Time.zone.today
      tournament = build(:tournament, start_date: date_now, end_date: date_now)
      expect(tournament).to be_valid
    end
  end
end
