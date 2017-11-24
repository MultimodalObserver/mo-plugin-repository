require 'rails_helper'

describe PluginPolicy do
  subject { PluginPolicy.new(user, plugin) }

  let(:plugin) { plugin = FactoryGirl.create(:plugin, :github) }

  context 'being a visitor' do
    let(:user) { nil }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'being a normal user (not the plugin owner)' do
    let(:user) { FactoryGirl.create(:user) }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }

    it { is_expected.to forbid_action(:accept_plugin) }
    it { is_expected.to forbid_action(:reject_plugin) }
  end

  context 'being a banned user' do
    let(:user) { FactoryGirl.create(:user, :banned) }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }

    it { is_expected.to forbid_action(:accept_plugin) }
    it { is_expected.to forbid_action(:reject_plugin) }
  end

  context 'being an admin' do
    let(:user) { FactoryGirl.create(:user, :admin) }

    it { is_expected.to permit_action(:accept_plugin) }
    it { is_expected.to permit_action(:reject_plugin) }
  end

  context 'being the plugin owner' do
    let(:user) { User.find(plugin.user_id) }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }

    it { is_expected.to forbid_action(:accept_plugin) }
    it { is_expected.to forbid_action(:reject_plugin) }
  end

  context 'being the plugin owner (but banned)' do
    let(:user) {
      u = User.find(plugin.user_id)
      u.status = :banned
      u.save!
      return u
    }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }

    it { is_expected.to forbid_action(:accept_plugin) }
    it { is_expected.to forbid_action(:reject_plugin) }
  end

end
