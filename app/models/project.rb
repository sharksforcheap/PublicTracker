class Project < ActiveRecord::Base
  belongs_to :user
  has_many :stories
  
  validates_uniqueness_of :pt_project_id, { :message => "You have already created a PublicTracker for this project."}
end
