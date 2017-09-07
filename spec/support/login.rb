module Login

  def login_as_admin
    user = User.new(email: "admin12345@mail.jp", role: :admin, password: "123456789", password_confirmation: "123456789")
    user.save
    login_as user
  end

  def login_as_moderator
    user = User.new(email: "mod12345@mail.jp", role: :moderator, password: "123456789", password_confirmation: "123456789")
    user.save
    login_as user
  end

  def login_as_normal_user
    user = User.new(email: "normal12345@mail.jp", role: :normal_user, password: "123456789", password_confirmation: "123456789")
    user.save
    login_as user
  end


  def login_as(user)
    before(:each) do
      allow(@controller).to receive(:current_user) { user }
    end
  end

end
