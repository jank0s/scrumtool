class Story < ActiveRecord::Base
    belongs_to :project
    belongs_to :priority

    validates :project_id, :presence => true
    validates :name, :presence => true
    validates :description, :presence => true
    validates :priority_id, :presence => true
    validates :value, :presence => true
    validates :finished, :presence => true
end
