require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  test 'valid categories' do
    assert build(:valid_category1).valid?
    assert build(:valid_category2).valid?
    assert build(:valid_category3).valid?
    assert build(:valid_category4).valid?
    assert build(:valid_category5).valid?
  end

  test 'invalid categories' do
    assert build(:invalid_category1).invalid?
    assert build(:invalid_category2).invalid?
  end

  test 'categories are trimmed ad squished' do
    category = build(:valid_category_spaces)
    category.validate
    assert category.name == 'a b'
    assert category.shortname == 'sho rtn ame'
  end

end
