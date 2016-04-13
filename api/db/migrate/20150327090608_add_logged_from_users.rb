class AddLoggedFromUsers < ActiveRecord::Migration
  def change
    add_column :users, :logged, :integer, default: 0
  end
end
