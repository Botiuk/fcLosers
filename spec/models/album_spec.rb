# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Album do
  it 'is valid with valid attributes' do
    album = build(:album)
    expect(album).to be_valid
  end

  it 'is not valid without a name' do
    album = build(:album, name: nil)
    expect(album).not_to be_valid
  end

  it 'is valid with not uniq name' do
    album_one = create(:album)
    album_two = build(:album, name: album_one.name)
    expect(album_two).to be_valid
  end

  it 'is not valid without a album_date' do
    album = build(:album, album_date: nil)
    expect(album).not_to be_valid
  end

  it 'is not valid with album_date grater today' do
    album = build(:album, album_date: (Time.zone.today + 1))
    expect(album).not_to be_valid
  end
end
