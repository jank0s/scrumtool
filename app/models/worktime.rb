class Worktime < ActiveRecord::Base
  belongs_to :task

  validates :done, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 30}
  validates :remaining, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 30}
end
