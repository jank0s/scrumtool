class Sprint < ActiveRecord::Base

  belongs_to :project

  validates :start, presence: true
  validates :end, presence: true
  validates :velocity, presence: true, numericality: {only_integer: true}
  validates :project_id, presence: true

  validate :check_start_not_in_past, :check_start_before_end, :check_overlapping

  private
  def check_start_before_end
    if self[:start] < self[:end]
      return true
    else
      errors.add(:start, "must be before end")
    end
  end

  def check_start_not_in_past
    if self[:start] >= Date.today
      return true
    else
      errors.add(:start, "cannot be in past")
    end
  end

  def check_overlapping

    sprint = Sprint.last

    if sprint == nil
      return true
    else
      if sprint.end > self[:start]
        errors.add(:start, "new sprint should be after all existing sprints")
      else
        return true
      end
    end
=begin
    sprints = Sprint.all

    sprints.each do |sprint|
      if self[:start]
    end
=end
  end

end
