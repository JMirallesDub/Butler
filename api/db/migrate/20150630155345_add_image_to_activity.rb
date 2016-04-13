class AddImageToActivity < ActiveRecord::Migration
  def change
  	add_attachment :activities, :image
  end
end
