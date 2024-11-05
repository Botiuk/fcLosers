# frozen_string_literal: true

class Tournament < ApplicationRecord
  validates :name, :start_date, presence: true
  validates :end_date, comparison: { greater_than_or_equal_to: :start_date }, allow_blank: true
end
