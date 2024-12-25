# frozen_string_literal: true

FactoryBot.define do
  factory :game_album do
    game { FactoryBot.create(:game) }
    album { FactoryBot.create(:album) }
  end
end
