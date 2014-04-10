class Task < ActiveRecord::Base
	belongs_to :story

	validates :name, :presence => true, length: {minimum: 2, maximum: 255}, :uniqueness => {:case_sensitive => false}
	validates :time_estimation, :presence => true
	#:numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 20}, :allow_blank => true

end
