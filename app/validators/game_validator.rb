# frozen_string_literal: true

class GameValidator < ActiveModel::Validator
  def validate(rec)
    rec.errors.add :base, I18n.t('errors.game_validator.same_team') if rec.home_team_id == rec.visitor_team_id
    return unless (rec.home_goal.present? && rec.visitor_goal.nil?) || (rec.home_goal.nil? && rec.visitor_goal.present?)

    rec.errors.add :base, I18n.t('errors.game_validator.score')
  end
end
