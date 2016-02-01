class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.integer :kwh_rate, null: false
      t.integer :kwh_credit, null: false
      t.integer :kwh_generated, null: false
      t.integer :consumed, null: false
      t.integer :sent_to_grid, null: false
      t.integer :savings_consumed, null: false
      t.integer :credit_grid, null: false
      t.integer :savings_before_distribution, null: false
      t.integer :distribution_charge, null: false
      t.integer :total_savings, null: false

      t.timestamps null: false
    end
  end
end
