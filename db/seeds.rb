# frozen_string_literal: true

require 'faker'

case Rails.env
when 'development'

  PressService.create(
    email: 'svetabotiuk@gmail.com',
    password: ENV.fetch('SEEDS_PASS', nil),
    password_confirmation: ENV.fetch('SEEDS_PASS', nil)
  )

  15.times do
    Article.create(
      title: Faker::Movie.title.capitalize,
      article_type: Article.article_types.keys.sample,
      published_at: Faker::Time.between(from: DateTime.now - 1.year, to: DateTime.now + 1.month)
    )
  end
  ActiveStorage::Blob.create!(
    key: 'qmxtu8zeyorsceuzd7futpw4hyyw',
    filename: 'ball.jpg',
    content_type: 'image/jpeg',
    metadata: '{"identified":true,"width":1300,"height":920,"analyzed":true}',
    service_name: 'cloudinary',
    byte_size: 151_321,
    checksum: 'wSps1y9oB3nGIibHYWAX7A=='
  )
  article_ids = Article.ids
  article_ids.each do |article_id|
    ActiveStorage::Attachment.create!(
      record_type: 'Article',
      record_id: article_id,
      name: 'cover',
      blob_id: 1
    )
    ActionText::RichText.create!(
      record_type: 'Article',
      record_id: article_id,
      name: 'content',
      body: Faker::Lorem.paragraph_by_chars
    )
  end

  ActiveStorage::Blob.create!(
    key: 'ochx8crdnsnw5k7lv3tj71507m7t',
    filename: 'empty_photo.jpg',
    content_type: 'image/jpeg',
    metadata: '{"identified":true,"width":380,"height":380,"analyzed":true}',
    service_name: 'cloudinary',
    byte_size: 5704,
    checksum: 'Yp8xTVxnrsK16TZ6wJaPbw=='
  )

  50.times do
    Player.create(
      name: Faker::Name.first_name,
      surname: Faker::Name.last_name,
      date_of_birth: Faker::Date.between(from: 40.years.ago, to: 16.years.ago),
      which_team: Player.which_teams.keys.sample,
      position: Player.positions.keys.sample,
      player_number: Faker::Number.between(from: 1, to: 99),
      height: Faker::Number.between(from: 1.60, to: 2.15).round(2),
      weight: Faker::Number.between(from: 55.0, to: 90.0).round(1),
      leg: Player.legs.keys.sample
    )
  end
  players_ids = Player.ids
  players_ids.each do |player_id|
    ActiveStorage::Attachment.create!(
      record_type: 'Player',
      record_id: player_id,
      name: 'player_photo',
      blob_id: 2
    )
    ActionText::RichText.create!(
      record_type: 'Player',
      record_id: player_id,
      name: 'player_biography',
      body: Faker::Lorem.paragraph_by_chars
    )
  end

  10.times do
    Coach.create(
      name: Faker::Name.first_name,
      middle_name: Faker::Name.middle_name,
      surname: Faker::Name.last_name,
      date_of_birth: Faker::Date.between(from: 40.years.ago, to: 16.years.ago),
      which_team: Coach.which_teams.keys.sample,
      position: Coach.positions.keys.sample
    )
  end
  coaches_ids = Coach.ids
  coaches_ids.each do |coach_id|
    ActiveStorage::Attachment.create!(
      record_type: 'Coach',
      record_id: coach_id,
      name: 'coach_photo',
      blob_id: 2
    )
    ActionText::RichText.create!(
      record_type: 'Coach',
      record_id: coach_id,
      name: 'coach_biography',
      body: Faker::Lorem.paragraph_by_chars
    )
  end

  Team.create(
    team_type: 'ФК',
    name: 'Невдахи',
    represent: 'Тернопіль'
  )

  Team.create(
    team_type: 'ФК',
    name: 'Невдахи-2',
    represent: 'Тернопіль'
  )

  Team.create(
    team_type: 'ФК',
    name: 'Невдахи U19',
    represent: 'Тернопіль'
  )

  50.times do
    Team.create(
      team_type: [Faker::Alphanumeric.alphanumeric(number: 2, min_alpha: 2).upcase, nil].sample,
      name: Faker::Sports::Football.team,
      represent: Faker::Address.city
    )
  end
  teams_ids = Team.ids
  teams_ids.each do |team_id|
    ActiveStorage::Attachment.create!(
      record_type: 'Team',
      record_id: team_id,
      name: 'team_logo',
      blob_id: 2
    )
  end

  20.times do
    random_date = Faker::Date.between(from: 5.years.ago, to: 1.month.ago)
    Tournament.create(
      start_date: random_date,
      schema_type: Tournament.schema_types.keys.sample,
      end_date: random_date + rand(2..12).month,
      name: Faker::Sports::Football.competition
    )
  end

  tournament_ids = Tournament.ids
  team_ids = Team.ids - [1]
  100.times do
    TournamentTeam.create(
      tournament_id: tournament_ids.sample,
      team_id: team_ids.sample
    )
  end
  tournament_ids.each do |tournament_id|
    TournamentTeam.create(
      tournament_id: tournament_id,
      team_id: 1
    )
  end

  30.times do
    Stadium.create(
      country: Faker::Address.country,
      region: Faker::Address.state,
      district: Faker::Address.state,
      loctype: Stadium.loctypes.keys.sample,
      location_name: Faker::Address.city,
      address: Faker::Address.street_address,
      stadium_name: Faker::Restaurant.name
    )
  end

  stadium_ids = Stadium.ids
  champ_tournament_ids = Tournament.where(schema_type: %w[national_champ national_champ_second
                                                          national_champ_u19]).ids
  champ_tournament_ids.each do |tournament_id|
    team_ids = TournamentTeam.where(tournament_id: tournament_id).pluck(:team_id)
    50.times do
      Game.create(
        tournament_id: tournament_id,
        game_type: Game.game_types.keys.sample,
        stage: Faker::Number.non_zero_digit + Faker::Number.digit,
        stadium_id: stadium_ids.sample,
        game_date: Faker::Date.between(from: 1.year.ago, to: 1.year.since),
        start_time: [Time.zone.now, nil].sample,
        home_team_id: team_ids.sample,
        home_goal: Faker::Number.number(digits: 1),
        visitor_team_id: team_ids.sample,
        visitor_goal: Faker::Number.number(digits: 1)
      )
    end
  end

  cup_tournament_ids = Tournament.where(schema_type: 'national_cup').ids
  cup_stage = ['1/32', '1/16', '1/8', '1/4', '1/2', 'Фінал']
  cup_tournament_ids.each do |tournament_id|
    team_ids = TournamentTeam.where(tournament_id: tournament_id).pluck(:team_id)
    15.times do
      Game.create(
        tournament_id: tournament_id,
        game_type: Game.game_types.keys.sample,
        stage: cup_stage.sample,
        stadium_id: stadium_ids.sample,
        game_date: Faker::Date.between(from: 1.year.ago, to: 1.year.since),
        start_time: [Time.zone.now, nil].sample,
        home_team_id: team_ids.sample,
        home_goal: Faker::Number.number(digits: 1),
        visitor_team_id: team_ids.sample,
        visitor_goal: Faker::Number.number(digits: 1)
      )
    end
  end

  friendly_tournament_ids = Tournament.where(schema_type: 'friendly').ids
  friendly_tournament_ids.each do |tournament_id|
    team_ids = TournamentTeam.where(tournament_id: tournament_id).pluck(:team_id)
    5.times do
      Game.create(
        tournament_id: tournament_id,
        game_type: Game.game_types.keys.sample,
        stage: nil,
        stadium_id: stadium_ids.sample,
        game_date: Faker::Date.between(from: 1.year.ago, to: 1.year.since),
        start_time: [Time.zone.now, nil].sample,
        home_team_id: team_ids.sample,
        home_goal: Faker::Number.number(digits: 1),
        visitor_team_id: team_ids.sample,
        visitor_goal: Faker::Number.number(digits: 1)
      )
    end
  end

  game_ids = Game.ids
  game_ids.each do |game_id|
    ActionText::RichText.create!(
      record_type: 'Game',
      record_id: game_id,
      name: 'game_protocol',
      body: Faker::Lorem.paragraph_by_chars
    )
  end

  20.times do
    Video.create(
      name: Faker::Movie.title,
      youtube_id: Faker::Alphanumeric.alpha(number: 10)
    )
  end

  game_ids = Game.ids
  video_ids = Video.ids
  video_ids.each do |video_id|
    GameVideo.create(
      game_id: game_ids.sample,
      video_id: video_id
    )
  end

  10.times do
    Album.create(
      name: Faker::Music.album,
      album_date: Faker::Date.between(from: 1.year.ago, to: Time.zone.today)
    )
  end

  album_ids = Album.ids
  album_ids.each do |album_id|
    ActiveStorage::Attachment.create!(
      record_type: 'Album',
      record_id: album_id,
      name: 'photos',
      blob_id: 1
    )
  end
  game_ids = Game.ids
  album_ids.each do |album_id|
    GameAlbum.create(
      game_id: game_ids.sample,
      album_id: album_id
    )
  end

when 'production'

  press_service = PressService.where(email: 'fcLosers@gmail.com').first_or_initialize
  press_service.update!(
    password: ENV.fetch('SEEDS_PASS', nil),
    password_confirmation: ENV.fetch('SEEDS_PASS', nil)
  )

  Team.where(id: 1).first_or_initialize do |team|
    team.team_type = 'ФК'
    team.name = 'Невдахи'
    team.represent = 'Тернопіль'
  end

  Team.where(id: 2).first_or_initialize do |team|
    team.team_type = 'ФК'
    team.name = 'Невдахи-2'
    team.represent = 'Тернопіль'
  end

  Team.where(id: 3).first_or_initialize do |team|
    team.team_type = 'ФК'
    team.name = 'Невдахи U19'
    team.represent = 'Тернопіль'
  end
end
