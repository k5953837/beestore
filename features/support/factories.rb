FactoryGirl.define do

  factory :user do
    password '12345678'
    password_confirmation '12345678'

    trait :admin_user do
      email 'admin_user@example.com'
    end

    trait :normal_user do
      email 'normal_user@example.com'
    end

    trait :premium_user do
      email 'premium_user@example.com'
    end

    factory :admin_user, traits: [:admin_user] do
      after(:create) do |user|
        user.is_admin = true
        user.save
      end
    end

    factory :normal_user, traits: [:normal_user] do
      after(:create) do |user|
      end
    end

    factory :premium_user, traits: [:normal_user] do
      after(:create) do |user|
        user.is_premium = true
        user.save
      end
    end
  end
end
