FactoryGirl.define do

  # Valid categories

  factory :valid_category1, class: Category do
    name "a"
    shortname  "s"
  end

  factory :valid_category2, class: Category do
    name "aaa"
    shortname  "SsAs"
  end

  factory :valid_category3, class: Category do
    name "a"
    shortname  "ssd-aSd--"
  end

  factory :valid_category4, class: Category do
    name "a"
    shortname  " ssd-aSd--"
  end

  factory :valid_category5, class: Category do
    name "a  "
    shortname  "ssd-aSd--"
  end

  factory :valid_category_spaces, class: Category do
    name "a    b "
    shortname  "    sho   rtn   ame  "
  end


  # Invalid categories

  factory :invalid_category1, class: Category do
    name ""
    shortname  "s "
  end

  factory :invalid_category2, class: Category do
    name "a"
    shortname  "ss3d-aSd--"
  end
end
