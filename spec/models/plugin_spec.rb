require 'rails_helper'

RSpec.describe Plugin, type: :model do
  it "is a correct plugin" do
    plugin = FactoryGirl.build(:plugin)
    expect(plugin).to be_valid
  end

  it "has an empty repository url" do
    plugin = FactoryGirl.build(:plugin, :repository_url => "")
    expect(plugin).to_not be_valid
  end

  it "gives the correct releases url (Github)" do
    plugin = FactoryGirl.build(:plugin, :repository_url => "https://github.com/FeloVilches/mo-plugin-repository")
    repo_url = plugin.get_repository_data
    expect(repo_url[:repo_type]).to eq 'github'
    expect(repo_url[:user_name]).to eq 'FeloVilches'
    expect(repo_url[:repo_name]).to eq 'mo-plugin-repository'
  end

  it "gives the correct releases url (Github) even if no HTTPS was included" do
    plugin = FactoryGirl.build(:plugin, :repository_url => "github.com/FeloVilches/mo-plugin-repository")
    repo_url = plugin.get_repository_data
    expect(repo_url[:repo_type]).to eq 'github'
    expect(repo_url[:user_name]).to eq 'FeloVilches'
    expect(repo_url[:repo_name]).to eq 'mo-plugin-repository'
  end
end
