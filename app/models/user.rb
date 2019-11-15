class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events
  enum role: [:teacher, :admin]
  after_initialize :set_default_role, :if => :new_record?
  before_create :set_default_role

  def set_default_role
    self.role ||= :teacher
  end

  def clock_in_today?
    self.events.today.clock_in.present?
  end

  def clock_out_today?
    self.events.today.clock_out.present?
  end

  def event_type
    if self.clock_out_today? && self.clock_in_today?
      self.events.order('updated_at ASC').try(:last).try(:type) == 'ClockOut' ? ClockIn : ClockOut
    elsif self.clock_in_today?
      ClockOut
    elsif self.clock_out_today?
      ClockIn
    elsif !self.clock_out_today? && !self.clock_in_today?
      ClockIn
    end
  end
end
