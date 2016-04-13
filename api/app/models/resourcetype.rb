class Resourcetype < ActiveRecord::Base

	has_many :resource
	has_one :scheduleheader, :dependent => :destroy

	validates :name,
			  :presence => true,
			:uniqueness => true
	validates :capacity_resource,
			  :presence => true,
	          :numericality => {:integer => true, :greater_than_or_equal_to => 1}
end
