module Login

  def login_as(user)
    before(:each) do
      allow(@controller).to receive(:current_user) { user }
    end
  end

end
