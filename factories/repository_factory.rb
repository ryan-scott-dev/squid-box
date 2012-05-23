FactoryGirl.define do
  factory :repository do
    name "Test Repository"
    path "git://github.com/mojombo/grit.git"
  end
end
