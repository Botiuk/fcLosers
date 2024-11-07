# frozen_string_literal: true

FactoryBot.define do
  factory :tournament do
    random_date = Faker::Date.between(from: 5.years.ago, to: 1.year.ago)
    name { Faker::Sports::Football.competition }
    schema_type { Tournament.schema_types.keys.sample }
    start_date { random_date }
    end_date { [random_date + rand(2..12).month, nil].sample }
  end
end
