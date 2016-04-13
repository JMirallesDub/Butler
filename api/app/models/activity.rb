class Activity < ActiveRecord::Base
  belongs_to :branchoffice
  has_many :activitiesofroom, dependent: :destroy
  has_many :room, :through => :activitiesofroom
  has_many :scheduleheader, :dependent => :destroy

  validates :name, 
			 :presence => true,
			 :length => { in: 2..256 }

  validates :branchoffice_id,
			  :numericality => { :allow_blank => true }

  has_attached_file :image, styles: { medium: '200x200>', thumb: '48x48>' },
  					:url => "/images/activity/activity_:id/:style/:basename.:extension",
            :default_url =>"/images/default/:style/logo.png"

  validates_attachment :image,	
					:content_type => {:content_type => ["image/jpeg","image/gif","image/png"]},
					:size => {:less_than => 2.megabytes}
		
end
