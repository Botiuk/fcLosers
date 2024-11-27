# frozen_string_literal: true

class GameValidator < ActiveModel::Validator
  def validate(rec)
    return unless (rec.home_goal.present? && rec.visitor_goal.nil?) || (rec.home_goal.nil? && rec.visitor_goal.present?)

    rec.errors.add :base, I18n.t('errors.game_validator.score')
  end
end
