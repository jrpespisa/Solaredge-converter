class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.decimal :tax_credit
      t.decimal :srec_credit
      t.integer :user_id, null: false
    end
  end
end
