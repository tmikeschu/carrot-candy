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

    points 0

    redeemed_points 0

    factory :user_with_rewards do
      after(:create) do |user|
        user.rewards = create_list(:reward, 10)
      end
    end
  end

  factory :reward do
    sequence :name do |n|
      "#{Faker::Commerce.product_name} #{n}"
    end

    sequence :quantity do
      rand(20) + 1
    end

    sequence :point_value do
      rand(500) + 1
    end

    sequence :image_url do
      Faker::Avatar.image
    end
  end
end