# frozen_string_literal: true

class GameAlbum < ApplicationRecord
  belongs_to :game
  belongs_to :album

  validates :album_id, uniqueness: true
end
