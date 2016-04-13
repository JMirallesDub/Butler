class Branchoffice < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  belongs_to :company_type
  has_many :activity, :dependent => :destroy
  has_many :room, :dependent => :destroy
  has_many :scheduleheader, :dependent => :destroy

  validates :name, 
			 :presence => true,
			 :length => { in: 2..256 }

  validates :direccion, 
			 :presence => true,
			 :length => { in: 2..256 }

	validates :user_id,
			  :presence => true,
			  :numericality => { :only_integer => true }

	validates :company_id,
			  :presence => true,
			  :numericality => { :only_integer => true }

	validates :company_type_id,
			  :presence => true,
			  :numericality => { :only_integer => true }

	has_attached_file :image, styles: { medium: '200x200>', thumb: '48x48>' },
					  :url =>"/images/branchoffice/branchoffice_:id/:style/:basename.:extension",
					  :default_url =>"/images/default/:style/logo.png"

	validates_attachment :image,	
					:content_type => {:content_type => ["image/jpeg","image/gif","image/png"]},
					:size => {:less_than => 2.megabytes}

end
