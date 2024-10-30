# frozen_string_literal: true

class ChangeCoachValidator < ActiveModel::Validator
  def validate(record)
    if record.position == 'main_coach'
      main_coach = Coach.where(which_team: record.which_team, position: 'main_coach').first
      if main_coach.present? && main_coach.id != record.id
        record.errors.add :base, I18n.t('errors.coach_validations.main')
      end
    end
    return unless record.position == 'temporary_main_coach'

    temporary_main_coach = Coach.where(which_team: record.which_team, position: 'temporary_main_coach').first
    return if temporary_main_coach.blank?

    record.errors.add :base, I18n.t('errors.coach_validations.temporary') if temporary_main_coach.id != record.id
  end
end
