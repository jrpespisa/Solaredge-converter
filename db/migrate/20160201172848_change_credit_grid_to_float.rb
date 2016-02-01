class ChangeCreditGridToFloat < ActiveRecord::Migration
  def change
    change_column :queries, :credit_grid, :float
  end
end
