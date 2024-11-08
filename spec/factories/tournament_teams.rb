# frozen_string_literal: true

FactoryBot.define do
  factory :tournament_team do
    tournament { FactoryBot.create(:tournament) }
    team { FactoryBot.create(:team) }
  end
end
