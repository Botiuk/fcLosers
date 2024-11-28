# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :tournament
  belongs_to :stadium
  belongs_to :home_team, class_name: 'Team'
  belongs_to :visitor_team, class_name: 'Team'

  has_rich_text :game_protocol

  validates :home_goal, :visitor_goal, numericality: { only_integer: true, greater_than_or_equal_to: 0 },
                                       allow_nil: true
  validates_with GameValidator
  validates :game_type, presence: true
  validates :game_date, presence: true,
                        if: :score_or_time_present?

  enum :game_type, { group: 0, play_off: 1, friendly: 2 }, prefix: true

  def score_or_time_present?
    (home_goal.present? && visitor_goal.present?) || start_time.present?
  end
end
