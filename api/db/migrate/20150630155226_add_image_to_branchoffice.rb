class AddImageToBranchoffice < ActiveRecord::Migration
  def change
  	add_attachment :branchoffices, :image
  end
end
