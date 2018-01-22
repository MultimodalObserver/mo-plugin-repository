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

  context 'visibility #show' do

    context 'owner can see plugin' do
      let(:user) { User.find(plugin.user_id) }
      it { is_expected.to permit_action(:show) }
    end

    context 'a different user can see plugin' do
      let(:user) { FactoryGirl.create(:user) }
      it { is_expected.to permit_action(:show) }
    end

    context 'a visitor can see confirmed plugin' do
      let(:user) { nil }
      it { is_expected.to permit_action(:show) }
    end

    context 'a visitor cannot see rejected plugin' do
      let(:user) { nil }
      let(:plugin) { FactoryGirl.create(:plugin, :rejected) }
      it { is_expected.to forbid_action(:show) }
    end

    context 'a visitor cannot see pending plugin' do
      let(:user) { nil }
      let(:plugin) { FactoryGirl.create(:plugin, :pending) }
      it { is_expected.to forbid_action(:show) }
    end

    context 'admin can see pending plugin' do
      let(:user) { FactoryGirl.create(:user, :admin) }
      let(:plugin) { FactoryGirl.create(:plugin, :pending) }
      it { is_expected.to permit_action(:show) }
    end

    context 'owner (normal user) can see his/her pending plugin' do
      let(:user) { FactoryGirl.create(:user, :normal_user) }
      let(:plugin) { FactoryGirl.create(:plugin, :pending, :user_id => user.id) }
      it { is_expected.to permit_action(:show) }
    end

    context 'user who is not the owner cannot see a pending plugin' do
      let(:user) { FactoryGirl.create(:user, :normal_user) }
      let(:plugin) { FactoryGirl.create(:plugin, :pending) }
      it { is_expected.to forbid_action(:show) }
    end

    context 'user who is not the owner cannot see a rejected plugin' do
      let(:user) { FactoryGirl.create(:user, :normal_user) }
      let(:plugin) { FactoryGirl.create(:plugin, :rejected) }
      it { is_expected.to forbid_action(:show) }
    end

    context 'admin cannot see nil plugin' do
      let(:user) { FactoryGirl.create(:user, :admin) }
      let(:plugin) { nil }
      it { is_expected.to forbid_action(:show) }
    end

  end

end
