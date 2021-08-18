shared_context('when user is authenticated') do
  let!(:user) { create(:user) }

  before do
    allow_any_instance_of(::Authentication).to receive(:authenticate_user).and_return(user)
    allow_any_instance_of(::Authentication).to receive(:current_user).and_return(user)
  end
end
