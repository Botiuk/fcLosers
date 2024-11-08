# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TournamentTeam do
  describe 'validations' do
    it 'is valid with valid attributes' do
      tournament_team = build(:tournament_team)
      expect(tournament_team).to be_valid
    end

    it 'is not valid without a tournament_id' do
      tournament_team = build(:tournament_team, tournament_id: nil)
      expect(tournament_team).not_to be_valid
    end

    it 'is not valid without a team_id' do
      tournament_team = build(:tournament_team, team_id: nil)
      expect(tournament_team).not_to be_valid
    end

    it 'is not valid with same tournament_id and same team_id' do
      tournament_team_one = create(:tournament_team)
      tournament_team_two = build(:tournament_team, tournament_id: tournament_team_one.tournament_id,
                                                    team_id: tournament_team_one.team_id)
      expect(tournament_team_two).not_to be_valid
    end
  end
end
