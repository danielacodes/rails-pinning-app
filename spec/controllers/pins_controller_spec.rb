require 'spec_helper'
RSpec.describe PinsController do

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
      it 'responds with successfully' do
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
    
end