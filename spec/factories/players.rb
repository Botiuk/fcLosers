# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    date_of_birth { Faker::Date.between(from: 40.years.ago, to: 16.years.ago) }
    which_team { Player.which_teams.keys.sample }
    position { Player.positions.keys.sample }
    player_number { Faker::Number.between(from: 1, to: 99) }
    height { Faker::Number.between(from: 1.60, to: 2.15).round(2) }
    weight { Faker::Number.between(from: 55.0, to: 90.0).round(1) }
    leg { Player.legs.keys.sample }
  end
end
