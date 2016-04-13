class Book < ActiveRecord::Base
  belongs_to :scheduleheader
  belongs_to :schedulebody
  belongs_to :resource
  belongs_to :user
  belongs_to :bookstatus

  
end
