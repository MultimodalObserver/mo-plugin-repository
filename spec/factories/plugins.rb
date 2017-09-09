FactoryGirl.define do
  factory :plugin do
    name "a"

    sequence :short_name { |n| "short-name#{n}" }

    repository_url "https://github.com/aaa/bbb"

    trait :github { repository_url "https://github.com/FeloVilches/mo-plugin-repository" }

    trait :bitbucket { repository_url "https://bitbucket.org/caseywdunn/cnidaria2014" }

    trait :blank_repo_url { repository_url "" }

    association :user
  end
end
