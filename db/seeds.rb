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
  (1..15).each do |article_id|
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

when 'production'

  press_service = PressService.where(email: 'fcLosers@gmail.com').first_or_initialize
  press_service.update!(
    password: ENV.fetch('SEEDS_PASS', nil),
    password_confirmation: ENV.fetch('SEEDS_PASS', nil)
  )

end
