module Login

  def login_as_admin
    user = FactoryGirl.build(:admin)
    login_as user
    return user
  end

  def login_as_moderator
    user = FactoryGirl.build(:moderator)
    login_as user
    return user
  end

  def login_as_normal_user
    user = FactoryGirl.build(:normal_user)
    login_as user
    return user
  end

  def login_as(user)
    before(:each) do
      allow(@controller).to receive(:current_user) { user }
    end
  end

end
