# frozen_string_literal: true

FactoryBot.define do
  factory :coach do
    name { Faker::Name.first_name }
    middle_name { Faker::Name.last_name }
    surname { Faker::Name.last_name }
    date_of_birth { Faker::Date.between(from: 40.years.ago, to: 16.years.ago) }
    which_team { Coach.which_teams.keys.sample }
    position { Coach.positions.keys.sample }
  end
end
