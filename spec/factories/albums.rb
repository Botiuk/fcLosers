# frozen_string_literal: true

FactoryBot.define do
  factory :album do
    name { Faker::Music.album }
    album_date { Faker::Date.between(from: 1.year.ago, to: Time.zone.today) }
  end
end
