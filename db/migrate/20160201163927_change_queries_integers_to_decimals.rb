class ChangeQueriesIntegersToDecimals < ActiveRecord::Migration
  def up
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

  def down
    change_table :queries do |t|
      t.change :kwh_rate, :integer
      t.change :kwh_credit, :integer
      t.change :kwh_generated, :integer
      t.change :consumed, :integer
      t.change :sent_to_grid, :integer
      t.change :savings_consumed, :integer
      t.change :savings_before_distribution, :integer
      t.change :distribution_charge, :integer
      t.change :total_savings, :integer
    end
  end
end
