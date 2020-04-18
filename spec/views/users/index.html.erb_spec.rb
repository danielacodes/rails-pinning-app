require 'spec_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email1",
        :password => "Password"
      ),
      User.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email2",
        :password => "Password"
      )
    ])
  end

  after(:each) do
    user = User.find_by_email("Email1")
    if !user.nil?
      user.destroy
    end
    user = User.find_by_email("Email2")
    if !user.nil?
      user.destroy
    end
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email1".to_s, :count => 1
    assert_select "tr>td", :text => "Email2".to_s, :count => 1
    assert_select "tr>td", :text => "Password".to_s, :count => 2
  end
end
