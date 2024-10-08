# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { Faker::Movie.title.capitalize }
    article_type { Article.article_types.keys.sample }
    published_at { Faker::Time.between(from: DateTime.now - 1.year, to: DateTime.now) }
  end
end
