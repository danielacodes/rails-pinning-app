require 'spec_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :first_name => "First Name",
      :last_name => "Last Name",
      :email => "Email3",
      :password => "Password"
    ))
  end

  after(:each) do
    user = User.find_by_email("Email3")
    if !user.nil?
      user.destroy
    end
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Password/)
  end
end
