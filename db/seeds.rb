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

  50.times do
    Team.create(
      team_type: [Faker::Alphanumeric.alphanumeric(number: 2, min_alpha: 2).upcase, nil].sample,
      name: Faker::Sports::Football.team,
      represent: Faker::Address.city
    )
  end

when 'production'

  press_service = PressService.where(email: 'fcLosers@gmail.com').first_or_initialize
  press_service.update!(
    password: ENV.fetch('SEEDS_PASS', nil),
    password_confirmation: ENV.fetch('SEEDS_PASS', nil)
  )

end
