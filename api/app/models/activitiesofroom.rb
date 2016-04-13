class Activitiesofroom < ActiveRecord::Base
  has_many :activity
  has_many :room

  validates :room_id,
			  :numericality => { :only_integer => true }
  validates :activity_id,
			  :numericality => { :only_integer => true }
end
