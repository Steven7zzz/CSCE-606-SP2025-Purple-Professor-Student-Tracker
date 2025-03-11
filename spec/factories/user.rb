FactoryBot.define do
    factory :user do
      email { "test@tamu.edu" }
      password { "password" }
      password_confirmation { "password" }
    end
  end