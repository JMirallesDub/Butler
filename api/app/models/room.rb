class Room < ActiveRecord::Base
  belongs_to :branchoffice
  has_many :activitiesofroom, :dependent => :destroy
  has_many :acitvity, :through => :activitiesofroom
  has_many :scheduleheader, :dependent => :destroy
 

  

  validates :name, 
			 :presence => true,
			 :length => { in: 2..256 }

  validates :branchoffice_id,
			  :numericality => { :allow_blank => true }

   
			  
end
