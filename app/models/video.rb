# frozen_string_literal: true

class Video < ApplicationRecord
  has_one :game_video, dependent: :destroy

  validates :name, presence: true
  validates :youtube_id, presence: true,
                         uniqueness: { case_sensitive: true, message: I18n.t('errors.messages.uniq_youtube_id') }

  def self.formhelper
    video_with_game_ids = GameVideo.pluck(:video_id)
    Video.where.not(id: video_with_game_ids).order(created_at: :desc, name: :desc).limit(20).pluck(:name, :id)
  end
end
