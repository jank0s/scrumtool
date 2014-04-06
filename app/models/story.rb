class Story < ActiveRecord::Base
    belongs_to :project
    belongs_to :priority

    validates :project_id, :presence => true
    validates :name, :presence => true, length: {minimum: 3}, uniqueness: true
    validates :description, :presence => true, length: {minimum: 3}
    validates :priority_id, :presence => true
    validates :value, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 100}, :allow_blank => true
end
