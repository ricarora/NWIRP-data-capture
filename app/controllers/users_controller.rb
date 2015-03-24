# Copyright (c) 2015 Richa Arora and Kate Fulton All Rights Reserved.
class UsersController < ApplicationController
  def index
     if params[:approved] == "false"
       @users = User.find_all_by_approved(false).sort_by {|user| user.email.downcase}
     else
       @users = User.all.sort_by {|user| user.email.downcase }
     end
   end

   def edit
     @user = User.find(params[:id])
   end

   def update
     user = User.find(params[:id])
     @current_user = current_user
     if current_user && current_user.admin
       if params[:approve] == "admin"
         user.approve_admin(@current_user)
       end
       if params[:approve] == "user"
         user.approve_user(@current_user)
       end
       if params[:approve] == "remove_admin"
         user.remove_admin(@current_user)
       end
       if user.save!
         redirect_to users_path, notice: "User updated."
       else
         redirect_to users_path, notice: "Unable to update user.."
       end
     else
       redirect_to users_path, notice: "Only admin can update users."
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
