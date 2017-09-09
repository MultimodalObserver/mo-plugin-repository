require 'rails_helper'

RSpec.describe Category, :type => :model do

  it "is valid with valid name" do
    expect(FactoryGirl.build(:category, name: "a")).to be_valid
    expect(FactoryGirl.build(:category, name: "aasd")).to be_valid
    expect(FactoryGirl.build(:category, name: "a  as a   a")).to be_valid
    expect(FactoryGirl.build(:category, name: "   a   ")).to be_valid
    expect(FactoryGirl.build(:category, name: "asadd")).to be_valid
  end

  it "is valid with valid short name" do
    expect(FactoryGirl.build(:category, short_name: "a ")).to be_valid
    expect(FactoryGirl.build(:category, short_name: "aasd")).to be_valid
    expect(FactoryGirl.build(:category, short_name: "  asda--sd-sASA-SaSSA ")).to be_valid
  end

  it "has invalid name" do
    expect(FactoryGirl.build(:category, short_name: "")).to_not be_valid
    expect(FactoryGirl.build(:category, short_name: "   ")).to_not be_valid
    expect(FactoryGirl.build(:category, short_name: "       ")).to_not be_valid
  end

  it "has invalid short name" do
    expect(FactoryGirl.build(:category, short_name: "asd s")).to_not be_valid
    expect(FactoryGirl.build(:category, short_name: "  asd-asda-asdwe- s ")).to_not be_valid
    expect(FactoryGirl.build(:category, short_name: "       ")).to_not be_valid
  end

  it "is trimmed and squished" do
    category = FactoryGirl.build(:category, :name => "   dd    d ", :short_name => " a-34fd-df   ")
    category.validate
    expect(category.name).to eq("dd d")
    expect(category.short_name).to eq("a-34fd-df")
  end


end
