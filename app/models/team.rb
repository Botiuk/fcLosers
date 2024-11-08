# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :tournament_teams, dependent: nil
  has_one_attached :team_logo

  validates :name, :represent, presence: true
  validates :name, uniqueness: { case_sensitive: false, scope: %i[team_type represent] }
end
