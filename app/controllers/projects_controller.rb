class ProjectsController < ApplicationController
  def new
    puts current_user.token
    if current_user.token == nil
      flash[:warning] = "Please enter a PivotalTracker API Token"
      redirect_to edit_user_registration_path
    else 
      
    end
  end

  def create
  end
end
