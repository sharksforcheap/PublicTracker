class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :upvote]
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
      end
    end
  end

  def create
    @project = current_user.projects.build(params[:project])
    pt_name = PivotalTracker::Project.all.find(@project.pt_project_id).first.name
   
    if @project.save
      Story.populate_stories(@project.id, current_user)
       if @project.stories.empty?
          @project.destroy
          redirect_to projects_path, notice: "No public stories in #{pt_name.inspect}. Import aborted" and return
        end
      flash[:notice] = "Project Created!"
      redirect_to project_path(@project) 
    else
      PivotalTracker::Client.token = current_user.token
      @projects = PivotalTracker::Project.all
      render :action => "new"
    end
  end
    
  def show
    @project = Project.find(params[:id])
    @stories = @project.stories.sort
  end
  
  def edit
    @project = current_user.projects.find(params[:id])
  end
  
  def update
    @project = current_user.projects.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to projects_path, notice: 'project was successfully updated.'
    else
      render action: "edit" 
    end
  end
  
  def destroy
    @project = current_user.projects.find(params[:id])
    @project.destroy
    redirect_to projects_url
  end
  
  def add_token
    current_user.update_attribute(:token, params[:token])
    redirect_to new_project_path
  end
  
  def upvote
    story = Story.find(params[:id])
    session[:voting] ||= {}
    unless session[:voting][story.id]
      story.upvote
      session[:voting][story.id] = true
      redirect_to project_path(Project.find(story.project_id)), :notice => "Vote successful!" and return
    end
    redirect_to project_path(Project.find(story.project_id)), :notice => "You have already voted!"
  end
end
