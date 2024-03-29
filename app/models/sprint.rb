class Sprint < ActiveRecord::Base

  belongs_to :project

  has_many :stories #new

  validates :start, presence: true
  validates :end, presence: true
  validates :velocity, presence: true, :numericality => {:greater_than_or_equal_to => 1, :less_than_or_equal_to => 1000}
  validates :project_id, presence: true

  #validate :check_start_not_in_past, :check_start_before_end, :check_overlapping

  private
  def check_start_before_end
    if self[:start] >= self[:end]
      errors.add(:start, "must be before end")
    end
  end

  def check_start_not_in_past

    if !self[:id]
      if self[:start] < Date.today
        errors.add(:start, "cannot be in past")
      end
    end
  end

  def check_overlapping

    sprint = Sprint.where(project_id: self[:project_id])

    if sprint == nil
      return true
    else
      sprint.each do |s|
        if s.id != self[:id]
          if s.start >= self[:start] && s.start <= self[:end]
            errors[:base] << "Overlapping with another sprint1"
          elsif s.end >= self[:start] && s.end <= self[:end]
            errors[:base] << "Overlapping with another sprint2"
          elsif s.start < self[:start] && s.end > self[:end]
            errors[:base] << "Overlapping with another sprint3"
          end
        end
      end

    end

  end

end
