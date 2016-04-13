class Scheduleheader < ActiveRecord::Base
	belongs_to :branchoffice
	belongs_to :room
	belongs_to :activity
	has_many :schedulebody, :dependent => :destroy 
	belongs_to :resourcetype
	has_many :resource
	has_many :book

	validates :branchoffice_id,
	          :presence => true,
	          :numericality => {:integer => true, :greater_than_or_equal_to => 1}

	validates :room_id,
	          :presence => true,
	          :numericality => {:integer => true, :greater_than_or_equal_to => 1}

	validates :activity_id,
	          :presence => true,
	          :numericality => {:integer => true, :greater_than_or_equal_to => 1}

	validates :resourcetype_id,
	          :numericality => {:allow_blank => true}

	validates :capacity,
	          :presence => true,
	          :numericality => {:integer => true, :greater_than_or_equal_to => 1}
	


	private

		

end
