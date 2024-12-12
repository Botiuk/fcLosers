# frozen_string_literal: true

FactoryBot.define do
  factory :game_video do
    game { FactoryBot.create(:game) }
    video { FactoryBot.create(:video) }
  end
end
