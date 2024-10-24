# frozen_string_literal: true

class CoachValidator < ActiveModel::Validator
  def validate(record)
    if record.position == 'main_coach'
      main_coach = Coach.where(which_team: record.which_team, position: 'main_coach')
      record.errors.add :base, I18n.t('errors.coach_validations.main') if main_coach.present?
    end
    return unless record.position == 'temporary_main_coach'

    temporary_main_coach = Coach.where(which_team: record.which_team, position: 'temporary_main_coach')
    return if temporary_main_coach.blank?

    record.errors.add :base, I18n.t('errors.coach_validations.temporary')
  end
end
