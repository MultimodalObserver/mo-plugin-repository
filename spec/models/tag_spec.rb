require 'rails_helper'

RSpec.describe Tag, :type => :model do

  it "is valid with valid name" do
    expect(FactoryGirl.build(:tag, name: "a")).to be_valid
    expect(FactoryGirl.build(:tag, name: "aasd")).to be_valid
    expect(FactoryGirl.build(:tag, name: "a  as a   a")).to be_valid
    expect(FactoryGirl.build(:tag, name: "   a   ")).to be_valid
    expect(FactoryGirl.build(:tag, name: "asadd")).to be_valid
  end

  it "is valid with valid short name" do
    expect(FactoryGirl.build(:tag, short_name: "a ")).to be_valid
    expect(FactoryGirl.build(:tag, short_name: "aasd")).to be_valid
    expect(FactoryGirl.build(:tag, short_name: "  asda--sd-sASA-SaSSA ")).to be_valid
  end

  it "has a unique short name" do
    FactoryGirl.create(:tag, short_name: "aaa ")
    expect { FactoryGirl.create(:tag, short_name: "   AaA ") }.to raise_error ActiveRecord::RecordInvalid
  end

  it "has invalid name" do
    expect(FactoryGirl.build(:tag, short_name: "")).to_not be_valid
    expect(FactoryGirl.build(:tag, short_name: "   ")).to_not be_valid
    expect(FactoryGirl.build(:tag, short_name: "       ")).to_not be_valid
  end

  it "has invalid short name" do
    expect(FactoryGirl.build(:tag, short_name: "asd s")).to_not be_valid
    expect(FactoryGirl.build(:tag, short_name: "  asd-asda-asdwe- s ")).to_not be_valid
    expect(FactoryGirl.build(:tag, short_name: "       ")).to_not be_valid
  end

  it "is downcased, trimmed and squished" do
    tag = FactoryGirl.create(:tag, :name => "   dd    d ", :short_name => " a-34fD-DF   ")
    tag.validate
    expect(tag.name).to eq("dd d")
    expect(tag.short_name).to eq("a-34fd-df")
  end


end
