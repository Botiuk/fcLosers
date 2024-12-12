# frozen_string_literal: true

class Video < ApplicationRecord
  validates :name, presence: true
  validates :youtube_id, presence: true, uniqueness: { case_sensitive: true }
end
