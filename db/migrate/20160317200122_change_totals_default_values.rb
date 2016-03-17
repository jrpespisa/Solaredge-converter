class ChangeTotalsDefaultValues < ActiveRecord::Migration
  def up
    change_column :totals, :kwh_generated, :decimal, default: 0
    change_column :totals, :kwh_consumed, :decimal, default: 0
    change_column :totals, :savings_consumed, :decimal, default: 0
    change_column :totals, :sent_to_grid, :decimal, default: 0
    change_column :totals, :credit_grid, :decimal, default: 0
    change_column :totals, :savings_before_distribution, :decimal, default: 0
    change_column :totals, :distribution_charge, :decimal, default: 0
    change_column :totals, :total_savings, :decimal, default: 0
    change_column :totals, :user_id, :integer, null: false
  end

  def down
    change_column :totals, :kwh_generated, :decimal
    change_column :totals, :kwh_consumed, :decimal
    change_column :totals, :savings_consumed, :decimal
    change_column :totals, :sent_to_grid, :decimal
    change_column :totals, :credit_grid, :decimal
    change_column :totals, :savings_before_distribution, :decimal
    change_column :totals, :distribution_charge, :decimal
    change_column :totals, :total_savings, :decimal
    change_column :totals, :user_id, :integer, null: false
  end
end
