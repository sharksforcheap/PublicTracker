class User < ActiveRecord::Base
  has_many :projects
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :token
  
  validates_uniqueness_of :email, :case_sensitive => false
  validates_length_of :token, :is => 32, :if => :token, :allow_nil => true, :allow_blank => true
end
