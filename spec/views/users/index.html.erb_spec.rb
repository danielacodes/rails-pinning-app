require 'spec_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :password => "Password"
      ),
      User.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :password => "Password"
      )
    ])
  end

  after(:each) do
    users = User.all
    if !users.nil?
      users.destroy
    end
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Password".to_s, :count => 2
  end
end
