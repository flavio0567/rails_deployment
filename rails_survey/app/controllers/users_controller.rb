class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_correct_user, only: [:edit, :show, :update, :destroy]

  def new
   @user = User.new
  end

  def show
  	@user = User.find(params[:id])
    @groupss = Group.where(user_id: params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to groups_path,  notice: "User was successfully created!"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to main_path
    end
  end

  private

  def require_correct_user
    if current_user != User.find(params[:id])
      redirect_to "/users/#{session[:user_id]}"
    end
  end

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
