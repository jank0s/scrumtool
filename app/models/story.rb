class Story < ActiveRecord::Base
    belongs_to :project
    belongs_to :priority

    belongs_to :sprint #new

    has_many :tasks

    validates :project_id, :presence => true
    validates :name, :presence => true, length: {minimum: 3}, :uniqueness => {:case_sensitive => false}
    validates :description, :presence => true, length: {minimum: 3}
    validates :priority_id, :presence => true
    validates :value, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 100}, :allow_blank => true
    validates :timeestimates, :numericality => {:greater_than_or_equal_to => 0}, :allow_blank => true
end
