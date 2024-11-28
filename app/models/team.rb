# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :tournament_teams, dependent: nil
  has_one_attached :team_logo

  has_many :home_team_games, class_name: 'Game',
                             foreign_key: 'home_team_id',
                             dependent: nil,
                             inverse_of: :team
  has_many :visitor_team_games, class_name: 'Game',
                                foreign_key: 'visitor_team_id',
                                dependent: nil,
                                inverse_of: :team

  validates :name, :represent, presence: true
  validates :name, uniqueness: { case_sensitive: false, scope: %i[team_type represent] }

  def self.formhelper
    teams = Team.order(:name, :represent).pluck(:name, :id)
    teams.map do |element|
      element[0] = Team.where(id: element[1]).pluck(:team_type, :name, :represent).join(' ')
    end
    teams
  end

  def self.tournament_teams_formhelper(tournament_id)
    tournament_team_ids = TournamentTeam.where(tournament_id: tournament_id).pluck(:team_id)
    teams = Team.where(id: tournament_team_ids).order(:name, :represent).pluck(:name, :id)
    teams.map do |element|
      element[0] = Team.where(id: element[1]).pluck(:team_type, :name, :represent).join(' ')
    end
    teams
  end
end
