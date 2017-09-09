FactoryGirl.define do
  factory :plugin do
    name "a"

    sequence :short_name { |n| "short-name#{n}" }

    trait :github { repository_url "https://github.com/FeloVilches/mo-plugin-repository" }

    trait :bitbucket { repository_url "https://bitbucket.org/caseywdunn/cnidaria2014" }

    association :user
  end
end
