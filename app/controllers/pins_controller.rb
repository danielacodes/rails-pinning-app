class PinsController < ApplicationController
  before_action :require_login, :index, except: [:show, :show_by_name]
  
  def index
    @pins = Pin.all
  end
  
  def show
    @pin = Pin.find(params[:id])
    pinnings = @pin.pinnings.all
    ids = []

    # users who repinned
    pinnings.each do |pinning|
      id = pinning.user_id
      ids << id
    end

    @users = User.find ids
  end
  
  def show_by_name
    @pin = Pin.find_by_slug(params[:slug])
    pinnings = @pin.pinnings.all
    ids = []

    # users who repinned
    pinnings.each do |pinning|
      id = pinning.user_id
      ids << id
    end
    @users = User.find ids
    render :show
  end

  def new
    @pin = Pin.new
  end

  def create
    @pin = Pin.new(pin_params)

    if @pin.save      
      redirect_to pin_path(@pin)
    else       
      @errors = @pin.errors
      render :new
    end

  end

  def edit
    @pin = Pin.find(params[:id])
  end

  def update
    @pin = Pin.find(params[:id])
    @pin.update_attributes(pin_params)

    if @pin.save      
      redirect_to pin_path(@pin)
    else       
      @errors = @pin.errors
      render :edit
    end

  end

  def repin
    @pin = Pin.find(params[:id])
    @pin.pinnings.create(user: current_user)
    redirect_to user_path(current_user)
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :url, :slug, :text, :category_id, :image, :user_id)
  end

end