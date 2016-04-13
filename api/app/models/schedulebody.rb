class Schedulebody < ActiveRecord::Base
  belongs_to :scheduleheader
  has_many :book

end
