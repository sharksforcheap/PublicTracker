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
    if @project.save
      Story.populate_stories(@project.id, current_user)
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
