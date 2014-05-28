class Round < ActiveRecord::Base
	belongs_to :poker
	belongs_to :user
end
