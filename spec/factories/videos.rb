# frozen_string_literal: true

FactoryBot.define do
  factory :video do
    name { Faker::Movie.title }
    youtube_id { Faker::Alphanumeric.alpha(number: 10) }
  end
end
