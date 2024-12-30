# frozen_string_literal: true

class Tournament < ApplicationRecord
  has_many :tournament_teams, dependent: nil
  has_many :games, dependent: nil

  enum :schema_type, { national_champ: 0, national_cup: 1, friendly: 2,
                       national_champ_second: 3, national_champ_u19: 4 }, prefix: true

  validates :name, :schema_type, :start_date, presence: true
  validates :end_date, comparison: { greater_than_or_equal_to: :start_date }, allow_blank: true
end
