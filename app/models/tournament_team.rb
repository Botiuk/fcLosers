# frozen_string_literal: true

class TournamentTeam < ApplicationRecord
  belongs_to :tournament
  belongs_to :team

  validates :team_id, uniqueness: { scope: :tournament_id, message: I18n.t('errors.messages.tournament_team_uniq') }

  scope :order_by_team, -> { joins(:team).order('teams.name, teams.represent') }
end
