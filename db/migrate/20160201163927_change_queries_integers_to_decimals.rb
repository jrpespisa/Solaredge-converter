class ChangeQueriesIntegersToDecimals < ActiveRecord::Migration
  def change
    change_table :queries do |t|
      t.change :kwh_rate, :float
      t.change :kwh_credit, :float
      t.change :kwh_generated, :float
      t.change :consumed, :float
      t.change :sent_to_grid, :float
      t.change :savings_consumed, :float
      t.change :savings_before_distribution, :float
      t.change :distribution_charge, :float
      t.change :total_savings, :float
    end
  end
end
