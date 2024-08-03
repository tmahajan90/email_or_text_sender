class ImpersonationsController < ApplicationController
    before_action :authenticate_user! # Ensure user is logged in
    before_action :ensure_admin!, only: [:create] # Ensure current user is admin
  
    def create
      user = User.find(params[:user_id])
      session[:admin_id] = current_user.id # Store the admin's user ID
      sign_in(user) # Sign in as the target user
      redirect_to root_path, notice: "You are now impersonating #{user.email}"
    end
  
    def destroy
      user = User.find(session[:admin_id])
      sign_in(user) # Sign back in as the admin
      session[:admin_id] = nil # Clear the stored admin ID
      redirect_to root_path, notice: "Stopped impersonating"
    end
  
    private
  
    def ensure_admin!
      unless current_user.admin?
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end
end
  