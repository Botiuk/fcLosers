# frozen_string_literal: true

class Team < ApplicationRecord
  validates :name, :represent, presence: true
  validates :name, uniqueness: { case_sensitive: false, scope: %i[team_type represent] }
end
