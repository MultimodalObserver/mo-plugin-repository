require 'rails_helper'

RSpec.describe Category, :type => :model do

  it "is valid with valid attributes" do
    expect(FactoryGirl.build(:valid_category1)).to be_valid
    expect(FactoryGirl.build(:valid_category2)).to be_valid
    expect(FactoryGirl.build(:valid_category3)).to be_valid
    expect(FactoryGirl.build(:valid_category4)).to be_valid
    expect(FactoryGirl.build(:valid_category5)).to be_valid
  end

  it "is not valid" do
    expect(FactoryGirl.build(:invalid_category1)).to_not be_valid
    expect(FactoryGirl.build(:invalid_category2)).to_not be_valid
    expect(FactoryGirl.build(:invalid_category_spaces)).to_not be_valid
  end

  it "is trimmed and squished" do
    category = Category.new({ :name => "   dd    d ", :shortname => " a-34fd-df   " })
    category.validate
    expect(category.name).to eq("dd d")
    expect(category.shortname).to eq("a-34fd-df")
  end
end
