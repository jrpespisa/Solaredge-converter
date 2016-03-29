class AddInvestmentsToUser < ActiveRecord::Migration
  def change
    add_column :users, :initial_investment, :decimal, null: false
    add_column :users, :return_on_investment, :decimal, default: 0
  end
end
