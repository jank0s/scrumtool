class Teammember < ActiveRecord::Base
	belongs_to :project, :class_name => 'Project'
	belongs_to :user, :class_name => 'User'
end
