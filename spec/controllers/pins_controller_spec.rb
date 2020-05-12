require 'spec_helper'
RSpec.describe PinsController, type: :controller do

  before(:each) do 
    @pin = FactoryGirl.build(:pin)
    @user = FactoryGirl.create(:user)
    login(@user)
  end

  let(:valid_attributes) {
    {
      title: @pin.title,
      url: @pin.url,
      slug: @pin.slug,
      text: @pin.text,
      category: @pin.category,
      image: @pin.image
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

    describe "GET index" do

      it 'renders the index template' do
        get :index
        expect(response).to render_template('index')
      end

      it 'populates @pins with all pins' do
        get :index
        expect(assigns[:pins]).to eq(Pin.all)
      end

    end

    describe "GET new" do
      it 'responds with success' do
        get :new
        expect(response.success?).to be(true)
      end
      
      it 'renders the new view' do
        get :new      
        expect(response).to render_template(:new)
      end
      
      it 'assigns an instance variable to a new pin' do
        get :new
        expect(assigns(:pin)).to be_a_new(Pin)
      end
    end

    describe "POST create" do
  
      it 'responds with a redirect' do
        post :create, params: {pin: valid_attributes}
        expect(response).to redirect_to(Pin.last)
      end
  
      it 'creates a pin' do
        expect {
          post :create, params: {pin: valid_attributes}, session: valid_session
        }.to change(Pin, :count).by(1)
      end
  
      it 'redirects to the show view' do
        post :create, params: { pin: @pin_hash }
        expect(response).to redirect_to pin_url(assigns(:pin))
      end
  
      it 'redisplays new form on error' do
        # The title is required in the Pin model, so we'll
        # delete the title from the @pin_hash in order
        # to test what happens with invalid parameters
        post :create, params: {pin: invalid_attributes}, session: valid_session
        expect(response).to render_template(:new)
      end
  
      it 'assigns the @errors instance variable on error' do
        # The title is required in the Pin model, so we'll
        # delete the title from the @pin_hash in order
        # to test what happens with invalid parameters
        post :create, params: {user: invalid_attributes}, session: valid_session
        expect(assigns[:errors].present?).to be(true)
      end
  
    end

    describe "GET edit" do

      it 'responds with success' do
        pin = Pin.create! valid_attributes
        get :edit, params: {id: pin.to_param}, session: valid_session
        expect(response).to be_success
      end

      #renders the edit template

      #assigns an instance variable called @pin to the Pin with the appropriate id
    end
    
    describe "PUT update" do
      


    end

    describe "POST repin" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        login(@user)
        @pin = FactoryGirl.create(:pin)
      end

      it 'responds with a redirect' do
        post 'repin', params: { use_route: '/pins/repin/:id', id: @pin.id }
        expect(response.status).to eq(302)
      end

      it "Creates a pinning (the pin is now in the user's pins)" do
       post 'repin', params: { use_route: '/pins/repin/:id', id: @pin.id }
       pinning = @user.pinnings.last
       @id = pinning.pin_id
       expect(assigns(:pin)).to eq(Pin.find(@id))
      end

      it 'redirects to the user show page' do
        post 'repin', params: { use_route: '/pins/repin/:id', id: @pin.id }
        expect(response).to redirect_to(@user)
      end
    end
end