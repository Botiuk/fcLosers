# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team do
  it 'is valid with valid attributes' do
    team = build(:team)
    expect(team).to be_valid
  end

  it 'is not valid without a name' do
    team = build(:team, name: nil)
    expect(team).not_to be_valid
  end

  it 'is not valid without a represent' do
    team = build(:team, represent: nil)
    expect(team).not_to be_valid
  end

  it 'is valid without a team_type' do
    team = build(:team, team_type: nil)
    expect(team).to be_valid
  end

  it 'is not valid with same name and same team_type and represent' do
    team_one = create(:team)
    team_two = build(:team, team_type: team_one.team_type, name: team_one.name, represent: team_one.represent)
    expect(team_two).not_to be_valid
  end
end
