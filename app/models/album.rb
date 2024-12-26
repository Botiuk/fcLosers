# frozen_string_literal: true

class Album < ApplicationRecord
  has_one :game_album, dependent: :destroy
  has_many_attached :photos

  validates :name, presence: true
  validates :album_date, comparison: { less_than_or_equal_to: Time.zone.today }

  def self.formhelper
    album_with_game_ids = GameAlbum.pluck(:album_id)
    Album.where.not(id: album_with_game_ids).order(album_date: :desc, name: :desc).limit(20).pluck(:name, :id)
  end
end
