# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    team_type { Faker::Alphanumeric.alphanumeric(number: 2, min_alpha: 2).upcase }
    name { Faker::Sports::Football.team }
    represent { Faker::Address.city }
  end
end
