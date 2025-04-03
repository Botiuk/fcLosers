# frozen_string_literal: true

class Article < ApplicationRecord
  has_one_attached :cover
  has_rich_text :content

  enum :article_type, { games: 0, club_life: 1, press: 2 }, prefix: true

  validates :title, :article_type, presence: true

  validates_each :title do |record, attr, value|
    record.errors.add(attr, I18n.t('errors.messages.first_letter')) if /\A[[:lower:]]/.match?(value)
  end

  scope :articles_ordered, -> { order(published_at: :desc) }
end
