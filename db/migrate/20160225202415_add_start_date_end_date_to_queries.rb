class AddStartDateEndDateToQueries < ActiveRecord::Migration
  def change
    add_column :queries, :start_date, :date, null: false
    add_column :queries, :end_date, :date, null: false
  end
end
