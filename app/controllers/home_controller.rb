class HomeController < ApplicationController
  def index
    if user_signed_in? && current_user.token
      PivotalTracker::Client.token = current_user.token
      @projects = PivotalTracker::Project.all
      @first_project = @projects.first
      @public_stories = @first_project.stories.all(:label => 'public')
    end
  end
end