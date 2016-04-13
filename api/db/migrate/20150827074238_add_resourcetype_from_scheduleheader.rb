class AddResourcetypeFromScheduleheader < ActiveRecord::Migration
  def change
    add_reference :scheduleheaders, :resourcetype, index: true
    add_foreign_key :scheduleheaders, :resourcetypes
  end
end
