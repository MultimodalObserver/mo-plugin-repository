require 'rails_helper'

RSpec.describe User, :type => :model do

  it "is valid with valid attributes" do
    expect(FactoryGirl.build(:user1)).to be_valid
    expect(FactoryGirl.build(:user2)).to be_valid
    expect(FactoryGirl.build(:user3)).to be_valid
    expect(FactoryGirl.build(:user4)).to be_valid
  end

  it "is not valid" do
    expect { FactoryGirl.build(:user1_invalid) }.to raise_error(ArgumentError)
    expect { FactoryGirl.build(:user2_invalid) }.to raise_error(ArgumentError)
    expect(FactoryGirl.build(:user3_invalid)).to_not be_valid
    expect(FactoryGirl.build(:user4_invalid)).to_not be_valid
    expect(FactoryGirl.build(:user5_invalid)).to_not be_valid
  end

  it "has a trimmed all-lowercase email" do
    user = FactoryGirl.build :user2
    user.validate
    expect(user.email).to eq "normal@mail.jp"
  end

  it "has an easily accessible role attribute (and the default value works)" do
    expect(FactoryGirl.build(:user1).normal_user?).to be true
    expect(FactoryGirl.build(:user2).normal_user?).to be true
    expect(FactoryGirl.build(:user3).moderator?).to be true
    expect(FactoryGirl.build(:user4).admin?).to be true
  end

  it "has an easily accessible status attribute (and the default value works)" do
    expect(FactoryGirl.build(:user1).active?).to be true
    expect(FactoryGirl.build(:user2).deleted?).to be true
    expect(FactoryGirl.build(:user3).banned?).to be true
    expect(FactoryGirl.build(:user4).active?).to be true
  end

end
