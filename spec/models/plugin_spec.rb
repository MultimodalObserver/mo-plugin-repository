require 'rails_helper'

RSpec.describe Plugin, type: :model do
  it "is a correct plugin using Bitbucket" do
    plugin = FactoryGirl.create(:plugin, :github)
    expect(plugin).to be_valid
  end

  it "is a correct plugin using Bitbucket" do
    plugin = FactoryGirl.create(:plugin, :bitbucket)
    expect(plugin).to be_valid
    expect(plugin.repo_type.to_sym).to eq :bitbucket
  end

  it "has a unique short name" do
    FactoryGirl.create(:plugin, short_name: "aaa ")
    expect { FactoryGirl.create(:plugin, short_name: "   AaA ") }.to raise_error ActiveRecord::RecordInvalid
  end

  it "is downcased, trimmed and squished" do
    plugin = FactoryGirl.create(:plugin, :name => "  aS  ", :description => "  aa\n\n\n\n\n\n\n\n\naa  ", :short_name => "  a-Ad-V3  ", :repo_type => :github, :repo_user => " FF ", :repo_name => " cC   ", :home_page => " rR   ")
    expect(plugin).to be_valid
    expect(plugin.name).to eq "aS"
    expect(plugin.description).to eq "aa aa"
    expect(plugin.short_name).to eq "a-ad-v3"
    expect(plugin.repo_user).to eq "ff"
    expect(plugin.repo_name).to eq "cc"
    expect(plugin.home_page).to eq "rr"
  end


  it "validates empty repository urls" do
    plugin = FactoryGirl.build(:plugin, :blank_repo_url)
    expect(plugin).to_not be_valid
  end

  it "validates valid repository urls" do
    expect { FactoryGirl.create(:plugin, :repo_type => :githubo, :repo_user => "a", :repo_name => "愛") }.to raise_error ArgumentError
    expect { FactoryGirl.create(:plugin, :repo_type => :github, :repo_user => "     ", :repo_name => "愛") }.to raise_error ActiveRecord::RecordInvalid
    expect { FactoryGirl.create(:plugin, :repo_type => :github, :repo_user => "  a   ", :repo_name => "") }.to raise_error ActiveRecord::RecordInvalid
    expect { FactoryGirl.create(:plugin, :repo_type => :github, :repo_user => "  a   ", :repo_name => "  ") }.to raise_error ActiveRecord::RecordInvalid
  end




end
