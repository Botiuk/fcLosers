# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stadium do
  it 'is valid with valid attributes' do
    stadium = build(:stadium)
    expect(stadium).to be_valid
  end

  it 'is valid without contry' do
    stadium = build(:stadium, country: nil)
    expect(stadium).to be_valid
  end

  it 'is valid without region' do
    stadium = build(:stadium, region: nil)
    expect(stadium).to be_valid
  end

  it 'is valid without district' do
    stadium = build(:stadium, district: nil)
    expect(stadium).to be_valid
  end

  it 'is not valid without a loctype' do
    stadium = build(:stadium, loctype: nil)
    expect(stadium).not_to be_valid
  end

  it 'is not valid without a location_name' do
    stadium = build(:stadium, location_name: nil)
    expect(stadium).not_to be_valid
  end

  it 'is valid without address' do
    stadium = build(:stadium, address: nil)
    expect(stadium).to be_valid
  end

  it 'is not valid without a stadium_name' do
    stadium = build(:stadium, stadium_name: nil)
    expect(stadium).not_to be_valid
  end

  it 'is not valid with same stadium_name and same loctype and location_name' do
    stadium_one = create(:stadium)
    stadium_two = build(:stadium, stadium_name: stadium_one.stadium_name, loctype: stadium_one.loctype,
                                  location_name: stadium_one.location_name)
    expect(stadium_two).not_to be_valid
  end

  it 'is valid with same stadium_name and same loctype, other location_name' do
    stadium_one = create(:stadium)
    stadium_two = build(:stadium, stadium_name: stadium_one.stadium_name, loctype: stadium_one.loctype)
    expect(stadium_two).to be_valid
  end

  it 'is valid with same stadium_name and location_name, other loctype' do
    stadium_one = create(:stadium, loctype: 0)
    stadium_two = build(:stadium, stadium_name: stadium_one.stadium_name, location_name: stadium_one.location_name,
                                  loctype: [1, 2].sample)
    expect(stadium_two).to be_valid
  end
end
