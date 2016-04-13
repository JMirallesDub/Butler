class Resource < ActiveRecord::Base
  belongs_to :resourcetype
  belongs_to :scheduleheader
  has_many :book

  	validates :resourcetype_id,
	          :presence => true,
	          :numericality => {:integer => true, :greater_than_or_equal_to => 1}
   
	validates :scheduleheader_id,
	          :presence => true,
	          :numericality => {:integer => true, :greater_than_or_equal_to => 1}

	validates :name,
			  :presence => true,
			  :uniqueness => true

	
end
