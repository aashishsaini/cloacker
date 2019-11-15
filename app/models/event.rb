class Event < ApplicationRecord
  belongs_to :user
  scope :today, -> { where('time >= ?', Time.zone.now.beginning_of_day) }
  scope :clock_in, -> { where(type: 'ClockIn') }
  scope :clock_out, -> { where(type: 'ClockOut') }

  before_create :set_time

  def set_time
    self.time = Time.zone.now if self.time.blank?
  end

end
