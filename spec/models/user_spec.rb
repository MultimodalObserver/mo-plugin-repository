require 'rails_helper'

RSpec.describe User, :type => :model do

  it "is valid with valid attributes" do
    expect(FactoryGirl.build(:user, :normal_user, :active)).to be_valid
    expect(FactoryGirl.build(:user, :moderator, :active)).to be_valid
    expect(FactoryGirl.build(:user, :admin, :active)).to be_valid
    expect(FactoryGirl.build(:user, :normal_user, :banned)).to be_valid
    expect(FactoryGirl.build(:user, :moderator, :banned)).to be_valid
    expect(FactoryGirl.build(:user, :admin, :banned)).to be_valid
    expect(FactoryGirl.build(:user, email: "    ffff@aaaAa.com       ")).to be_valid
    expect(FactoryGirl.build(:user, email: "  aDmI!#$%&'*+-/=?^_`{|}~n@maiL.jp    ")).to be_valid
  end

  it "is not valid" do
    expect { FactoryGirl.build(:user, role: 3) }.to raise_error(ArgumentError)
    expect { FactoryGirl.build(:user, status: 3) }.to raise_error(ArgumentError)
    expect(FactoryGirl.build(:user, email: "asdasd asd a a a a a a a")).to_not be_valid
    expect(FactoryGirl.build(:user, password: "123456789", password_confirmation: "1234567890")).to_not be_valid
  end

  it "has a trimmed all-lowercase email" do
    user = FactoryGirl.build(:user, email: "  aDmI!#$%&'*+-/=?^_`{|}~n@maiL.jp    ")
    user.validate
    expect(user.email).to eq "admi!#$%&'*+-/=?^_`{|}~n@mail.jp"
  end

  it "has an easily accessible role attribute (and the default value works)" do
    expect(FactoryGirl.build(:user, :normal_user).normal_user?).to be true
    expect(FactoryGirl.build(:user, :moderator).moderator?).to be true
    expect(FactoryGirl.build(:user, :admin).admin?).to be true
  end

  it "has an easily accessible status attribute (and the default value works)" do
    expect(FactoryGirl.build(:user, :active).active?).to be true
    expect(FactoryGirl.build(:user, :banned).banned?).to be true
  end

  it "has a default status and role" do
    expect(FactoryGirl.build(:user).active?).to be true
    expect(FactoryGirl.build(:user).normal_user?).to be true
  end

end
