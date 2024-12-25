# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameAlbum do
  it 'is valid with valid attributes' do
    game_album = build(:game_album)
    expect(game_album).to be_valid
  end

  it 'is not valid without a album' do
    game_album = build(:game_album, album_id: nil)
    expect(game_album).not_to be_valid
  end

  it 'is not valid without a game' do
    game_album = build(:game_album, game_id: nil)
    expect(game_album).not_to be_valid
  end

  it 'is not valid with same album' do
    game_album_one = create(:game_album)
    game_album_two = build(:game_album, album_id: game_album_one.album_id)
    expect(game_album_two).not_to be_valid
  end
end
