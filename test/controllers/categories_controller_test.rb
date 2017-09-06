require 'test_helper'
require 'pp'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    FactoryGirl.create(:valid_category1)
    FactoryGirl.create(:valid_category2)
    FactoryGirl.create(:valid_category3)
    FactoryGirl.create(:valid_category4)
    FactoryGirl.create(:valid_category5)
  end

  test "should get index" do
    get categories_url, as: :json
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post categories_url, params: { category: { name: "aa", shortname: "b", a: 323 } }, as: :json
    end
    assert_response :created
  end

  test "shouldn't create category" do
    assert_no_difference('Category.count') do
      post categories_url, params: { category: { name: "aa", shortname: "2b", a: 323 } }, as: :json
    end
    assert_response :unprocessable_entity
  end


  test "should show category" do
    get category_url(1), as: :json
    assert_response :success
  end


  test "should update category" do
    patch category_url(1), params: { category: { shortname: "updatedvalue" } }, as: :json
    assert_response :success
  end

  test "shouldn't update category" do
    patch category_url(1), params: { category: { shortname: "updat edvalue " } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete category_url(1), as: :json
    end
    assert_response :no_content

    assert_difference('Category.count', -1) do
      delete category_url(2), as: :json
    end
    assert_response :no_content

    assert_raises(ActiveRecord::RecordNotFound) do
      get category_url(1), as: :json
    end
  end

end
