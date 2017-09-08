FactoryGirl.define do
  factory :category do

    sequence :name { |n| "name#{n}" }
    sequence :shortname { |n| "shortname#{n}" }
    
  end
end
