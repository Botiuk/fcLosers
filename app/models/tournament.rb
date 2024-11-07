# frozen_string_literal: true

class Tournament < ApplicationRecord
  enum :schema_type, { championship: 0, cup: 1, mixed: 2, friendly: 3 }, prefix: true

  validates :name, :schema_type, :start_date, presence: true
  validates :end_date, comparison: { greater_than_or_equal_to: :start_date }, allow_blank: true
end
