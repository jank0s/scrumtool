class Sprint < ActiveRecord::Base

  validates :start, presence: true
  validates :end, presence: true
  validates :velocity, presence: true, numericality: {only_integer: true}

  validate :raketa

  private
  def raketa
    if self[:start] < self[:end]
      return true
    else
      errors.add(:start, "must be before end")
    end
  end

end
