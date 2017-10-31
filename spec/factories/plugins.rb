FactoryGirl.define do
  factory :plugin do
    name "a"

    sequence :short_name { |n| "short-name#{n}" }

    r = Plugin.split_repository_data "https://github.com/aaa/bbb"
    repo_type r[:repo_type]
    repo_user r[:repo_user]
    repo_name r[:repo_name]

    trait :github {
      r = Plugin.split_repository_data "https://github.com/FeloVilches/mo-plugin-repository"
      repo_type :github
      repo_user r[:repo_user]
      repo_name r[:repo_name]
    }

    #trait :github {
    #  r = Plugin.split_repository_data "https://bitbucket.org/caseywdunn/cnidaria2014"
    #  repo_type :github
    #  repo_user r[:repo_user]
    #  repo_name r[:repo_name]
    #}

    trait :blank_repo_url {
      r = Plugin.split_repository_data ""
      repo_type r[:repo_type]
      repo_user r[:repo_user]
      repo_name r[:repo_name]
    }

    association :user

  end
end
