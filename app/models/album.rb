# frozen_string_literal: true

class Album < ApplicationRecord
  has_many_attached :photos

  validates :name, presence: true
  validates :album_date, comparison: { less_than_or_equal_to: Time.zone.today }
end
