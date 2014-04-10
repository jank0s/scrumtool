class Task < ActiveRecord::Base
	belongs_to :story

	validates :name, :presence => true, :uniqueness => {:case_sensitive => false}
	validates :time_estimation, :presence => true, :numericality => {:greater_than_or_equal_to => 1, :less_than_or_equal_to => 33}, :allow_blank => true
	#:numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 20}, :allow_blank => true

end
