class Project < ActiveRecord::Base
  belongs_to :user
  has_many :stories, :dependent => :destroy
  
  validates_uniqueness_of :pt_project_id, { :message => "You have already created a PublicTracker for this project."}
  validates_presence_of :name
end
