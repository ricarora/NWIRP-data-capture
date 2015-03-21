# Copyright (c) 2015 Richa Arora and Kate Fulton All Rights Reserved.

class HomeController < ApplicationController
  def index
    if !current_user
      redirect_to new_user_session_path
    end
  end
end
