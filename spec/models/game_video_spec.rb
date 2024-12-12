# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameVideo do
  it 'is valid with valid attributes' do
    game_video = build(:game_video)
    expect(game_video).to be_valid
  end

  it 'is not valid without a video' do
    game_video = build(:game_video, video_id: nil)
    expect(game_video).not_to be_valid
  end

  it 'is not valid without a game' do
    game_video = build(:game_video, game_id: nil)
    expect(game_video).not_to be_valid
  end

  it 'is not valid with same video' do
    game_video_one = create(:game_video)
    game_video_two = build(:game_video, video_id: game_video_one.video_id)
    expect(game_video_two).not_to be_valid
  end
end
