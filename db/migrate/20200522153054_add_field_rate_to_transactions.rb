class AddFieldRateToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :rate, :integer, :default=> 0
  end
end
