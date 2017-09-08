FactoryGirl.define do
  factory :plugin do
    name "a"
    repository_url "https://github.com/FeloVilches/mo-plugin-repository"
    association :user, factory: :user1

  end
end
