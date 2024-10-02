# frozen_string_literal: true

require 'faker'

case Rails.env
when 'development'

  PressService.create(
    email: 'svetabotiuk@gmail.com',
    password: ENV.fetch('SEEDS_PASS', nil),
    password_confirmation: ENV.fetch('SEEDS_PASS', nil)
  )

when 'production'

  press_service = PressService.where(email: 'fcLosers@gmail.com').first_or_initialize
  press_service.update!(
    password: ENV.fetch('SEEDS_PASS', nil),
    password_confirmation: ENV.fetch('SEEDS_PASS', nil)
  )

end
