class Sprint < ActiveRecord::Base

  validates :start, presence: true
  validates :end, presence: true
  validates :velocity, presence: true, numericality: {only_integer: true}

  validate :check_start_not_in_past, :check_start_before_end

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

end
