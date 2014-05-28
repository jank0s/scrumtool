class Poker < ActiveRecord::Base
	belongs_to :story
	has_many :rounds
end
