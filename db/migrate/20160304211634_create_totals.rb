class CreateTotals < ActiveRecord::Migration
  def change
    create_table :totals do |t|
      t.decimal :kwh_generated, null: false
      t.decimal :kwh_consumed, null: false
      t.decimal :savings_consumed, null: false
      t.decimal :sent_to_grid, null: false
      t.decimal :credit_grid, null: false
      t.decimal :savings_before_distribution, null: false
      t.decimal :distribution_charge, null: false
      t.decimal :total_savings, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end
  end
end
