FactoryBot.define do
  factory :staff_member do
    sequence(:email) { |n| "member#{n}@example.com" }
    family_name { "中村" }
    given_name { "勇希" }
    family_name_kana { "ナカムラ" }
    given_name_kana { "ユウキ" }
    password { "pw" }
    start_date { Date.yesterday }
    end_date { nil }
    suspended { false }
  end
end
