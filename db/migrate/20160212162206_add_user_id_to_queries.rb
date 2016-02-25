class AddUserIdToQueries < ActiveRecord::Migration
  def change
    add_column :queries, :user_id, :integer, null: false
  end
end
