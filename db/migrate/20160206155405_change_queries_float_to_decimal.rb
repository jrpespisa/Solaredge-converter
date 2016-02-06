class ChangeQueriesFloatToDecimal < ActiveRecord::Migration
  def up
    change_table :queries do |t|
      t.change :kwh_rate, :decimal
      t.change :kwh_credit, :decimal
      t.change :kwh_generated, :decimal
      t.change :consumed, :decimal
      t.change :sent_to_grid, :decimal
      t.change :savings_consumed, :decimal
      t.change :credit_grid, :decimal
      t.change :savings_before_distribution, :decimal
      t.change :distribution_charge, :decimal
      t.change :total_savings, :decimal
    end
  end

  def down
    change_table :queries do |t|
      t.change :kwh_rate, :float
      t.change :kwh_credit, :float
      t.change :kwh_generated, :float
      t.change :consumed, :float
      t.change :sent_to_grid, :float
      t.change :savings_consumed, :float
      t.change :credit_grid, :float
      t.change :savings_before_distribution, :float
      t.change :distribution_charge, :float
      t.change :total_savings, :float
    end
  end
end
