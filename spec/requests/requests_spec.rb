require "spec_helper"

RSpec.describe "Our Application Routes" do

  before(:each) do 
    @pin = FactoryGirl.build(:pin)
    @user = FactoryGirl.create(:user)
    login(@user)
  end

  after(:each) do
    @pin.destroy
    if !@user.destroyed?
      @user.destroy
    end
  end

  let(:valid_attributes) {
    {
      title: @pin.title,
      url: @pin.url,
      slug: @pin.slug,
      text: @pin.text,
      category_id: @pin.category_id,
      user_id: @pin.user_id
    } 
  }

  let(:invalid_attributes) {
    {
      title: @pin.title,
      slug: @pin.slug,
      category_id: @pin.category_id,
    } 
  }

  let(:valid_session) { {} }
  
  describe "GET /pins/name-:slug" do

    it 'renders the pins/show template' do
      get "/pins/name-#{@pin.slug}"
      expect(response).to render_template("pins/show")
    end

    it 'populates the @pin variable with the appropriate pin' do
      pin = Pin.first
      get "/pins/name-#{pin.slug}"
      expect(assigns[:pin]).to eq(Pin.find_by_slug(pin.slug))
    end

  end

end