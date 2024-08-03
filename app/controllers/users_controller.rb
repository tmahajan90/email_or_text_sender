class UsersController < ApplicationController
  before_action :set_user, except: [:index, :new, :create]
  before_action :check_permissions

  def index
    @users = User.where(role: 'user')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User created successfully."
      redirect_to new_user_path
    else
      flash.now[:alert] = "There was an error creating the user."
      render :new
    end
  end    

  def edit
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update(user_params)
      redirect_to users_url, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

    def check_permissions
      unless current_user.admin?
        flash[:alert] = "You do not have permission to perform this action."
        redirect_to root_path
      end
    end

    def set_user
      @user = User.find_by_id(current_user)
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
