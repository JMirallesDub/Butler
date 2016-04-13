class Company < ActiveRecord::Base
	belongs_to :user
	has_many :branchoffice, :dependent => :destroy

	validates :nombre, 
			 :uniqueness => true, 
			 :presence => true,
			 :length => { in: 2..256 }

	validates :user_id,
			  :presence => true,
			  :numericality => { :only_integer => true }



	
end
