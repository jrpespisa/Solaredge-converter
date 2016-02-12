class AddNameSiteIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :site_id, :integer, null: false
  end
end
