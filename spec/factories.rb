require 'factory_girl_rails'

FactoryGirl.define do
  factory :user do
    sequence :first_name do
      Faker::Name.first_name
    end

    sequence :last_name do
      Faker::Name.last_name
    end

    sequence :email do |n|
      "#{n}#{Faker::Internet.email}"
    end

    sequence :password do
      Faker::Internet.password(10, 50)
    end
  end
end