# frozen_string_literal: true

FactoryBot.define do
  factory :press_service do
    email { Faker::Internet.unique.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
