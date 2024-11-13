# frozen_string_literal: true

FactoryBot.define do
  factory :stadium do
    country { Faker::Address.country }
    region { Faker::Address.state }
    district { Faker::Address.state }
    loctype {  Stadium.loctypes.keys.sample }
    location_name { Faker::Address.city }
    address { Faker::Address.street_address }
    stadium_name { Faker::Restaurant.name }
  end
end
