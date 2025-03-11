FactoryBot.define do
    factory :peer_teacher do
      first_name { "Test" }
      last_name { "User" }
      uin { "123456789" }
      email { "testing@tamu.edu" }
    end
  end