class AddFieldsToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :bank_name, :string
    add_column :accounts, :agency_number, :string
    add_column :accounts, :type_account, :string
  end
end
