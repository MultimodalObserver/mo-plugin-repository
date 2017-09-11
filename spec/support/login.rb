module Login

  def login_as_admin
    user = FactoryGirl.create(:user, :admin)
    login_as user
    return user
  end

  def login_as_moderator
    user = FactoryGirl.create(:user, :moderator)
    login_as user
    return user
  end

  def login_as_normal_user
    user = FactoryGirl.create(:user)
    login_as user
    return user
  end

  def login_as(user)
    before(:each) do
      allow(@controller).to receive(:current_user) { user }
    end

    return user
  end

end
