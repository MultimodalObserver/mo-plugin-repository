FactoryGirl.define do
  factory :category do

    sequence :name do |n|
      "name#{n}"
    end

    sequence :shortname do |n|
      "shortname#{n}"
    end
  end
end
