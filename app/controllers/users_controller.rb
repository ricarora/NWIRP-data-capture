class UsersController < ApplicationController
  def index
     if params[:approved] == "false"
       @users = User.find_all_by_approved(false)
     else
       @users = User.all
     end
   end

   def edit
     @user = User.find(params[:id])
   end

   def update
     if current_user.admin
       raise
     end
   end

   def destroy
     @user = User.find(params[:id])
     if current_user && current_user.admin
       @user.destroy
       redirect_to users_path, notice: "User successfully removed."
     else
       redirect_to users_path, notice: "Unable to remove user."
     end
   end
 end
