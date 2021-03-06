class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  # pins repinned by user
    pinnings = current_user.pinnings.all
    ids = []
    pinnings.each do |pinning|
      id = pinning.pin_id
      ids << id
    end
  # pins created by user
    pins_created_by_user = Pin.where(:user_id => current_user.id)
    pins_created_by_user.each do |pin|
      own_id = pin.id
      ids << own_id
    end
  # all user's pins
    @pins = Pin.find ids
    # @pins = current_user.pins
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully logged in.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        @errors = @user.errors
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        @errors = @user.errors
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # LOGIN
  def login
  end

  def authenticate
    @user = User.authenticate(params[:email], params[:password])
      if @user.present?
          session[:user_id] = @user.id 
          redirect_to user_path(@user)
        else nil
          @errors = "Invalid email or password"
          render :login
      end
  end

  # LOGOUT
  def logout
    session.delete(:user_id)
    redirect_to login_path
  end

  # PRIVATE
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end

end
