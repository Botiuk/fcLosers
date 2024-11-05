# frozen_string_literal: true

class Player < ApplicationRecord
  before_validation :titleize_surname
  before_validation :titleize_name

  has_one_attached :player_photo
  has_rich_text :player_biography

  enum :which_team, { first: 0, second: 1, u19: 2 }, prefix: true
  enum :position, { goalkeeper: 0, defender: 1, midfielder: 2, forward: 3 }, prefix: true
  enum :leg, { right: 0, left: 1, both: 2 }, prefix: true

  validates :surname, :name, :which_team, :position, :height, :weight, :leg, presence: true
  validates :date_of_birth, presence: true,
                            comparison: { less_than_or_equal_to: (Time.zone.today - 12.years),
                                          message: I18n.t('errors.messages.player_older_than') }
  validates :player_number, presence: true,
                            uniqueness: { scope: :which_team, message: I18n.t('errors.messages.player_uniq_number') }

  scope :players_ordered, -> { order(:surname, :name, :player_number) }

  def self.team_players_with_position(team, player_position)
    Player.where(which_team: team, position: player_position).order(:player_number)
  end
end
