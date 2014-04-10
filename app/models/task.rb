class Task < ActiveRecord::Base
	belongs_to :story

	validates :time_estimation, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 20}, :allow_blank => true

end
