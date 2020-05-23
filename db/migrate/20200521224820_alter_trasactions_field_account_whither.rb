class AlterTrasactionsFieldAccountWhither < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :account_whither, :string
  end
end
