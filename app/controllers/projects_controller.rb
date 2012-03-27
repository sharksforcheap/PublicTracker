class ProjectsController < ApplicationController
  def new
    @project = Project.new
    if current_user.token == nil
      flash[:warning] = "Please enter a PivotalTracker API Token"
      redirect_to edit_user_registration_path
    else 
      if user_signed_in?
        PivotalTracker::Client.token = current_user.token
        @projects = PivotalTracker::Project.all
        puts @projects.inspect
      end
    end
  end

  def create
  end
end
