class CreateDeposits < ActiveRecord::Migration[6.0]
  def change
    create_table :deposits do |t|
      t.references :account, null: false, foreign_key: true
      t.string :account_number
      t.float :value

      t.timestamps
    end
  end
end
