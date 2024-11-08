# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :tournament_teams, dependent: nil
  has_one_attached :team_logo

  validates :name, :represent, presence: true
  validates :name, uniqueness: { case_sensitive: false, scope: %i[team_type represent] }

  def self.formhelper
    teams = Team.order(:name, :represent).pluck(:name, :id)
    teams.map do |element|
      element[0] = Team.where(id: element[1]).pluck(:team_type, :name, :represent).join(' ')
    end
    teams
  end
end
