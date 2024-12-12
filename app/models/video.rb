# frozen_string_literal: true

class Video < ApplicationRecord
  has_one :game_video, dependent: :destroy

  validates :name, presence: true
  validates :youtube_id, presence: true,
                         uniqueness: { case_sensitive: true, message: I18n.t('errors.messages.uniq_youtube_id') }
end
