FactoryGirl.define do
  factory :user do
    login "rscott"
    email "email@email.com"
    password "password"
    password_confirmation "password"
  end
end
