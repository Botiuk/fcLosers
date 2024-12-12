# frozen_string_literal: true

class GameVideo < ApplicationRecord
  belongs_to :game
  belongs_to :video

  validates :video_id, uniqueness: true
end
