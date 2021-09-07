FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 10) }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation {password}
    age_id                { 2 }
    sex_id                { 2 }
    voice_id              { 2 }
    profile               { Faker::Lorem.sentence }

    after(:build) do |user|
      user.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
