class Sprint < ActiveRecord::Base

  validates :velocity, presence: true, numericality: {only_integer: true}
end
