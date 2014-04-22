class Task < ActiveRecord::Base
	belongs_to :story
	has_many :worktimes
	
	validates :name, :presence => true, :uniqueness => {:case_sensitive => false}
	validates :time_estimation, :presence => true, :numericality => {:greater_than_or_equal_to => 1, :less_than_or_equal_to => 12}, :allow_blank => true

end
