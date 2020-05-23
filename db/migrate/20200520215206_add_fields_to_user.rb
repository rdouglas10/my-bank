class AddFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_column :users, :cpf, :string
    add_column :users, :data_nascimento, :date
  end
end
