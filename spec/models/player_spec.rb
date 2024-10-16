# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Player do
  it 'is valid with valid attributes' do
    player = build(:player)
    expect(player).to be_valid
  end

  it 'is not valid without a name' do
    player = build(:player, name: nil)
    expect(player).not_to be_valid
  end

  it 'is not valid without a surname' do
    player = build(:player, surname: nil)
    expect(player).not_to be_valid
  end

  it 'is not valid without a which_team' do
    player = build(:player, which_team: nil)
    expect(player).not_to be_valid
  end

  it 'is not valid without a position' do
    player = build(:player, position: nil)
    expect(player).not_to be_valid
  end

  it 'is not valid without a height' do
    player = build(:player, height: nil)
    expect(player).not_to be_valid
  end

  it 'is not valid without a weight' do
    player = build(:player, weight: nil)
    expect(player).not_to be_valid
  end

  it 'is not valid without a leg' do
    player = build(:player, leg: nil)
    expect(player).not_to be_valid
  end

  it 'is not valid without a date_of_birth' do
    player = build(:player, date_of_birth: nil)
    expect(player).not_to be_valid
  end

  it 'is not valid if a date_of_birth grater than' do
    player = build(:player, date_of_birth: (Time.zone.today - 12.years + 1.day))
    expect(player).not_to be_valid
  end

  it 'is valid if a date_of_birth equal' do
    player = build(:player, date_of_birth: (Time.zone.today - 12.years))
    expect(player).to be_valid
  end

  it 'is not valid without a player_number' do
    player = build(:player, player_number: nil)
    expect(player).not_to be_valid
  end

  it 'is not valid with not uniq player_number-which_team' do
    player_one = create(:player)
    player_two = build(:player, which_team: player_one.which_team, player_number: player_one.player_number)
    expect(player_two).not_to be_valid
  end
end
