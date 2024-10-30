# frozen_string_literal: true

class Coach < ApplicationRecord
  before_validation :titleize_name_surname
  before_validation :titleize_middle_name

  has_one_attached :coach_photo
  has_rich_text :coach_biography

  enum :which_team, { first: 0, second: 1, u_19: 2 }, prefix: true
  enum :position, { main_coach: 0, temporary_main_coach: 1, coach_helper: 2, coach: 3,
                    goalkeeper_coach: 4, physical_coach: 5, coach_analytic: 6, doctor: 7,
                    masseur: 8, administrator: 9, press: 10, consultant: 11 }, prefix: true

  validates :surname, :name, :middle_name, :which_team, :position, presence: true
  validates :date_of_birth, presence: true,
                            comparison: { less_than_or_equal_to: (Time.zone.today - 12.years), message: I18n.t('errors.messages.player_older_than') }
  validates_with CoachValidator, on: :create
  validates_with ChangeCoachValidator, on: :update

  scope :coaches_ordered, -> { order(:position, :surname, :name, :middle_name) }

  private

  def titleize_middle_name
    return if middle_name.blank?

    self.middle_name = if middle_name.sub('-', '').eql?(middle_name)
                         middle_name.split.map(&:capitalize).join(' ')
                       else
                         middle_name.tr('-', ' ').split.map(&:capitalize).join('-')
                       end
  end
end
