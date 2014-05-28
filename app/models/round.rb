class Round < ActiveRecord::Base
	belongs_to :poker
	has_many :entries
end
