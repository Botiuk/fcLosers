# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game do
  it 'is valid with valid attributes' do
    game = build(:game)
    expect(game).to be_valid
  end

  it 'is not valid without a tournament' do
    game = build(:game, tournament_id: nil)
    expect(game).not_to be_valid
  end

  it 'is not valid without a stadium' do
    game = build(:game, stadium_id: nil)
    expect(game).not_to be_valid
  end

  it 'is not valid without a game_type' do
    game = build(:game, game_type: nil)
    expect(game).not_to be_valid
  end

  it 'is not valid without a home_team' do
    game = build(:game, home_team_id: nil)
    expect(game).not_to be_valid
  end

  it 'is not valid without a visitor_team' do
    game = build(:game, visitor_team_id: nil)
    expect(game).not_to be_valid
  end

  it 'is valid without a stage' do
    game = build(:game, stage: nil)
    expect(game).to be_valid
  end

  it 'is valid without a start_time' do
    game = build(:game, start_time: nil)
    expect(game).to be_valid
  end

  it 'is not valid when a home_goal is less than 0' do
    game = build(:game, home_goal: -1)
    expect(game).not_to be_valid
  end

  it 'is not valid when a home_goal is not number' do
    game = build(:game, home_goal: 'One')
    expect(game).not_to be_valid
  end

  it 'is not valid when a home_goal is decimal' do
    game = build(:game, home_goal: 0.5)
    expect(game).not_to be_valid
  end

  it 'is valid when a home_goal is 0' do
    game = build(:game, home_goal: 0)
    expect(game).to be_valid
  end

  it 'is not valid when a visitor_goal is less than 0' do
    game = build(:game, visitor_goal: -2)
    expect(game).not_to be_valid
  end

  it 'is not valid when a visitor_goal is not number' do
    game = build(:game, visitor_goal: 'Two')
    expect(game).not_to be_valid
  end

  it 'is not valid when a visitor_goal is decimal' do
    game = build(:game, visitor_goal: 0.3)
    expect(game).not_to be_valid
  end

  it 'is valid when a visitor_goal is 0' do
    game = build(:game, visitor_goal: 0)
    expect(game).to be_valid
  end

  it 'is valid without home_goal and visitor_goal' do
    game = build(:game, home_goal: nil, visitor_goal: nil)
    expect(game).to be_valid
  end

  it 'is not valid when home_goal-visitor_goal diferent present or blank' do
    game = build(:game, home_goal: 1, visitor_goal: nil)
    expect(game).not_to be_valid
  end

  it 'is not valid when start_time present, game_date nil' do
    game = build(:game, home_goal: nil, visitor_goal: nil, game_date: nil)
    expect(game).not_to be_valid
  end

  it 'is valid without start_time, game_date, home_goal, visitor_goal' do
    game = build(:game, home_goal: nil, visitor_goal: nil, game_date: nil, start_time: nil)
    expect(game).to be_valid
  end

  it 'is not valid when home_goal and visitor_goal present, game_date nil' do
    game = build(:game, game_date: nil)
    expect(game).not_to be_valid
  end
end
