class Story < ActiveRecord::Base
  belongs_to :project
  # callback to set count
  
  def populate_stories(project_id, pt_project_id)
    @project_id = project_id
    @pt_project_id = pt_project_id
    PivotalTracker::Client.token = current_user.token
    @project = PivotalTracker::Project.find(pt_project_id) 
    @eligible_stories = @project.stories.all(:label => 'public', :story_type => ['feature'])
    @eligible_stories.each do |story|
      current_story = Story.find_or_create_by_pt_story_id(story.id)
      current_story.project_id = @project_id
      current_story.pt_project_id = @pt_project_id
      current_story.name = story.name
      current_story.description = story.description
      current_story.save
    end
  end
  
  # def set_count
  #   count = 0
  # end
end
