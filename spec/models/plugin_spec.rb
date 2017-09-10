require 'rails_helper'

RSpec.describe Plugin, type: :model do
  it "is a correct plugin" do
    plugin = FactoryGirl.create(:plugin, :github)
    expect(plugin).to be_valid
  end

  it "is downcased, trimmed and squished" do
    plugin = FactoryGirl.create(:plugin, :name => "  aS  ", :short_name => "  a-Ad-V3  ", :repo_type => :github, :repo_user => " ff ", :repo_name => " cc   ", :home_page => " rr   ")
    expect(plugin).to be_valid
    expect(plugin.name).to eq "aS"
    expect(plugin.short_name).to eq "a-ad-v3"
    expect(plugin.repo_user).to eq "ff"
    expect(plugin.repo_name).to eq "cc"
    expect(plugin.home_page).to eq "rr"
  end


  it "has an empty repository url" do
    plugin = FactoryGirl.build(:plugin, :blank_repo_url)
    expect(plugin).to_not be_valid
  end


end
