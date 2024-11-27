# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    tournament { FactoryBot.create(:tournament) }
    game_type { Game.game_types.keys.sample }
    stage { Faker::Alphanumeric.alpha(number: 3) }
    stadium { FactoryBot.create(:stadium) }
    game_date { Faker::Date.between(from: 1.year.ago, to: 1.year.since) }
    start_time { Time.zone.now }
    home_team { FactoryBot.create(:team) }
    home_goal { Faker::Number.number(digits: 1) }
    visitor_team { FactoryBot.create(:team) }
    visitor_goal { Faker::Number.number(digits: 1) }
  end
end
