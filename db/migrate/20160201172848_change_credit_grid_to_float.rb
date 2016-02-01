class ChangeCreditGridToFloat < ActiveRecord::Migration
  def up
    change_column :queries, :credit_grid, :float
  end

  def down
    change_column :queries, :credit_grid, :integer
  end
end
