FactoryGirl.define do
  factory :plugin do
    name "a"

    trait :github do
      repository_url "https://github.com/FeloVilches/mo-plugin-repository"
    end

    trait :bitbucket do
      repository_url "https://bitbucket.org/caseywdunn/cnidaria2014"
    end

    association :user
  end
end
