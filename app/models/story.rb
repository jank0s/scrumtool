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
    validate :validate_finished
    #validates :timeestimates, :numericality => {:greater_than_or_equal_to => 0.0, :less_than_or_equal_to => 100.0}

    def done?
        @t=tasks
        !@t.empty? && @t.where(completed: false).empty?
    end

    private
    def validate_finished
        if self[:finished]==true && !self.done?
            errors[:base] << "Story is not completed"
        else
            true
        end
    end
end
