class ProjectsController < ApplicationController
  def index
    @projects = current_user.projects.all
  end
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
    @project = current_user.projects.build(params[:project])
    if @project.save
      
      flash[:notice] = "Project Created!"
      redirect_to project_path(@project)
    else
      render 'projects/new'
    end
  end
    
  def show
    @project = current_user.projects.find(params[:id])
  end
end
