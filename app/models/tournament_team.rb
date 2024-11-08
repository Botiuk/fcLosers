# frozen_string_literal: true

class TournamentTeam < ApplicationRecord
  belongs_to :tournament
  belongs_to :team

  validates :team_id, uniqueness: { scope: :tournament_id }
end
