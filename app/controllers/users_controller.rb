class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,     only: :destroy


  def new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
    @entries = @user.entries.paginate(page: params[:page])
    @entry = @user.entries.build
  end

  def new
  	@user = User.new
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes(user_params)
      flash[:success] = "User information has been updated!"
      redirect_to current_user
    else
      render :edit
    end
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      login
      flash.now[:success] = "Welcome to our blog!"
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted!"
    redirect_to users_url
  end

  def user_params
  	params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to (root_url) unless @user == current_user
  end

  def admin_user    
    redirect_to(root_url) unless !current_user.nil? && current_user.admin?
  end
end
