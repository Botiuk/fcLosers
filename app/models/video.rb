# frozen_string_literal: true

class Video < ApplicationRecord
  validates :name, presence: true
  validates :youtube_id, presence: true,
                         uniqueness: { case_sensitive: true, message: I18n.t('errors.messages.uniq_youtube_id') }
end
