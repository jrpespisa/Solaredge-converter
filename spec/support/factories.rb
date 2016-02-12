FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "jsmith#{n}@gmail.com" }
    first_name "John"
    last_name "Smith"
    site_id "000000"
    password "password"
    password_confirmation "password"
  end
end
