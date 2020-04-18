require 'spec_helper'

RSpec.describe User, type: :model do

  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_session) { {} }
   
  it 'authenticates and returns a user when valid email and password passed in' do
    user = User.create! valid_attributes
    post :authenticate, params: {id: user.to_param}, session: valid_session
    expect(:user).to be(present)
  end
end
